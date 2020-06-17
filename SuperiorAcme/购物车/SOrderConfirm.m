//
//  SOrderConfirm.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOrderConfirm.h"
#import "SOrderConfirm_top.h"
#import "SOrderConfirm_header.h"
#import "SOrderConfirm_down.h"
#import "SOrderConfirm_footer.h"
#import "SOrderConfirmInvoice.h"
#import "SOrderConfirm_goodsCell.h"
#import "SOrderConfirm_addressCell.h"
#import "SAddress.h"
#import "SOrderSend.h"
#import "SPay.h"

#import "SOrderShoppingCart.h"
#import "SGroupBuyOrderShoppingCart.h"//拼单购结算页
#import "SPreOrderPreShoppingCart.h"//无界预购结算页
#import "SLimitBuyOrderShoppingCart.h"//限量购结算页
#import "SIntegralOrderShoppingCart.h"//积分抽奖结算页
#import "SAuctionOrderShoppingCart.h"//比价购结算页
#import "SIntegralBuyOrderShoppingCart.h"//无界商店结算页

#import "SAddressAddressList.h"//判断是否有默认地址
#import "SgiftShoppingCartModel.h"
#import "CleanConfirmOrderModel.h"

@interface SOrderConfirm () <UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * arr;//列表
    NSInteger  page;
    SOrderConfirm_top * top;
    NSString * model_address_id;
//    NSArray * jsonArr;//运费数据
    NSMutableArray * split_arr;
//    NSString * chice_freight;
    
    SOrderConfirm_down * down;
    
    BOOL firstComing;//NO第一次进来，YES判断是否有默认地址
    
    /*
     *无界商店返回的购买商品需要使用的积分
     */
    NSString * model_use_integral;
    NSString * is_active;
}
@property (strong, nonatomic) IBOutlet UITableView *mTable;
@property (strong, nonatomic) IBOutlet UILabel *sum_shop_price;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong, nonatomic) IBOutlet UILabel *sum_discount;
@property (weak, nonatomic) IBOutlet UILabel *send_price;
@property (weak, nonatomic) IBOutlet UILabel *country_tax;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *send_price_HHH;
@property (weak, nonatomic) IBOutlet UILabel *alltax_pay;
@property (weak, nonatomic) IBOutlet UILabel *express_fee;

//底部视图 iPhoneX上适配
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sumViewBottomCon;





@end

@implementation SOrderConfirm

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    adjustsScrollViewInsets_NO(_mTable, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"确认订单";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"SOrderConfirm_goodsCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SOrderConfirm_goodsCell"];
    [_mTable registerNib:[UINib nibWithNibName:@"SOrderConfirm_addressCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SOrderConfirm_addressCell"];
    
    top = [[SOrderConfirm_top alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 150)];
    _mTable.tableHeaderView = top;
    [top.addressBtn addTarget:self action:@selector(addressBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    down = [[SOrderConfirm_down alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 100)];
    _mTable.tableFooterView = down;
    
    [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    page = 1;
//    [self initRefresh];
    [self showModel];
    
    if(KIsiPhoneX){
        self.sumViewBottomCon.constant = HOME_INDICATOR_HEIGHT;
    }
}

- (void)initRefresh
{
    __block SOrderConfirm * blockSelf = self;
    _mTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [blockSelf showModel];
        
    }];
    _mTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [blockSelf showModel];
    }];
}
- (void)showModel {
    split_arr = [[NSMutableArray alloc] init];
    if ([_special_type isEqualToString:@"拼单购"]) {
        SGroupBuyOrderShoppingCart * list = [[SGroupBuyOrderShoppingCart alloc] init];
        list.goods_id = _goods_id;
        list.num = _num;
        list.order_type = [_special_type_sub isEqualToString:@"3"] ? @"2" : _special_type_sub;
        list.product_id = _product_id == nil ? @"" : _product_id;
        list.merchant_id = _merchant_id;
        list.group_buy_id = _group_buy_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sGroupBuyOrderShoppingCartSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SGroupBuyOrderShoppingCart * list = (SGroupBuyOrderShoppingCart *)data;
            if ([list.data.is_default isEqualToString:@"0"] || list.data.is_default == nil) {
                [top.addressBtn setTitle:@"请选择收货地址" forState:UIControlStateNormal];
            } else {
                [top.addressBtn setTitle:@"" forState:UIControlStateNormal];
                model_address_id = list.data.address_id;
                top.receiver.text = [NSString stringWithFormat:@"收货人:%@",list.data.receiver];
                top.phone.text = list.data.phone;
                top.address.text = [NSString stringWithFormat:@"%@ %@ %@ %@",list.data.province,list.data.city,list.data.area,list.data.address];
            }
            top.merchant_name.text = list.data.merchant_name;
            if ([list.data.sum_discount floatValue] < 0.01) {
                _sum_discount.hidden = YES;
            }
            _sum_discount.text = [NSString stringWithFormat:@"总抵扣金额￥%@",list.data.sum_discount];
            _sum_shop_price.text = [NSString stringWithFormat:@"￥%.2f",[list.data.sum_shop_price floatValue]];
            
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data.item];
                [_mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.item.count) {
                    
                    [arr addObjectsFromArray:list.data.item];
                    [_mTable.mj_footer endRefreshing];
                    
                } else {
                    
                    [_mTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [_mTable.mj_header endRefreshing];
            [_mTable reloadData];
            for (SGroupBuyOrderShoppingCart * list_split in arr) {
                NSMutableDictionary * dic_split = [[NSMutableDictionary alloc] init];
                [dic_split setValue:list_split.goods_id forKey:@"goods_id"];
                [dic_split setValue:list_split.num forKey:@"num"];
                [split_arr addObject:dic_split];
            }
            
            CGFloat countrynum = 0;//进口税金额
            for (SGroupBuyOrderShoppingCart * list in arr) {
                countrynum += [list.country_tax floatValue];
            }
            if (countrynum < 0.01) {
                _country_tax.text = @"";
            } else {
                _country_tax.text = [NSString stringWithFormat:@"+%.2f进口税",countrynum];
            }

        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else if ([_special_type isEqualToString:@"无界预购"]) {
        SPreOrderPreShoppingCart * list = [[SPreOrderPreShoppingCart alloc] init];
        list.pre_id = _pre_id;
        list.num = _num;
        list.order_type = @"2";
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sPreOrderPreShoppingCartSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SPreOrderPreShoppingCart * list = (SPreOrderPreShoppingCart *)data;
            if ([list.data.is_default isEqualToString:@"0"] || list.data.is_default == nil) {
                [top.addressBtn setTitle:@"请选择收货地址" forState:UIControlStateNormal];
            } else {
                [top.addressBtn setTitle:@"" forState:UIControlStateNormal];
                model_address_id = list.data.address_id;
                top.receiver.text = [NSString stringWithFormat:@"收货人:%@",list.data.receiver];
                top.phone.text = list.data.phone;
                top.address.text = [NSString stringWithFormat:@"%@ %@ %@ %@",list.data.province,list.data.city,list.data.area,list.data.address];
            }
            top.merchant_name.text = list.data.merchant_name;
            if ([list.data.sum_discount floatValue] < 0.01) {
                _sum_discount.hidden = YES;
            }
            _sum_discount.text = [NSString stringWithFormat:@"总抵扣金额￥%@",list.data.sum_discount];
            _sum_shop_price.text = [NSString stringWithFormat:@"￥%.2f",[list.data.sum_shop_price floatValue]];
            
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data.item];
                [_mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.item.count) {
                    
                    [arr addObjectsFromArray:list.data.item];
                    [_mTable.mj_footer endRefreshing];
                    
                } else {
                    
                    [_mTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [_mTable.mj_header endRefreshing];
            [_mTable reloadData];
            for (SPreOrderPreShoppingCart * list_split in arr) {
                NSMutableDictionary * dic_split = [[NSMutableDictionary alloc] init];
                [dic_split setValue:list_split.goods_id forKey:@"goods_id"];
                [dic_split setValue:list_split.num forKey:@"num"];
                [split_arr addObject:dic_split];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else if ([_special_type isEqualToString:@"积分抽奖"]) {
        SIntegralOrderShoppingCart * list = [[SIntegralOrderShoppingCart alloc] init];
        list.merchant_id = _merchant_id;
        list.num = _num;
        list.integral_id = _integral_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sIntegralOrderShoppingCartSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SIntegralOrderShoppingCart * list = (SIntegralOrderShoppingCart *)data;
            if ([list.data.is_default isEqualToString:@"0"] || list.data.is_default == nil) {
                [top.addressBtn setTitle:@"请选择收货地址" forState:UIControlStateNormal];
            } else {
                [top.addressBtn setTitle:@"" forState:UIControlStateNormal];
                model_address_id = list.data.address_id;
                top.receiver.text = [NSString stringWithFormat:@"收货人:%@",list.data.receiver];
                top.phone.text = list.data.phone;
                top.address.text = [NSString stringWithFormat:@"%@ %@ %@ %@",list.data.province,list.data.city,list.data.area,list.data.address];
            }
            top.merchant_name.text = list.data.merchant_name;
            if ([list.data.sum_discount floatValue] < 0.01) {
                _sum_discount.hidden = YES;
            }
            _sum_discount.text = [NSString stringWithFormat:@"总抵扣金额￥%@",list.data.sum_discount];
            _sum_shop_price.text = [NSString stringWithFormat:@"￥%.2f",[list.data.sum_shop_price floatValue]];
            
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data.item];
                [_mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.item.count) {
                    
                    [arr addObjectsFromArray:list.data.item];
                    [_mTable.mj_footer endRefreshing];
                    
                } else {
                    
                    [_mTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [_mTable.mj_header endRefreshing];
            [_mTable reloadData];
            for (SIntegralOrderShoppingCart * list_split in arr) {
                NSMutableDictionary * dic_split = [[NSMutableDictionary alloc] init];
                [dic_split setValue:list_split.goods_id forKey:@"goods_id"];
                [dic_split setValue:list_split.num forKey:@"num"];
                [split_arr addObject:dic_split];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else if ([_special_type isEqualToString:@"比价购"]) {
        SAuctionOrderShoppingCart * list = [[SAuctionOrderShoppingCart alloc] init];
        list.auction_id = _auction_id == nil ? @"" : _auction_id;
        if (_auction_isno == NO) {
            list.order_id = _order_id;
            list.buy_type = @"1";
        } else {
            list.order_id = @"";
            list.buy_type = @"0";
        }        
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sAuctionOrderShoppingCartSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SAuctionOrderShoppingCart * list = (SAuctionOrderShoppingCart *)data;
            if ([list.data.is_default isEqualToString:@"0"] || list.data.is_default == nil) {
                [top.addressBtn setTitle:@"请选择收货地址" forState:UIControlStateNormal];
            } else {
                [top.addressBtn setTitle:@"" forState:UIControlStateNormal];
                model_address_id = list.data.address_id;
                top.receiver.text = [NSString stringWithFormat:@"收货人:%@",list.data.receiver];
                top.phone.text = list.data.phone;
                top.address.text = [NSString stringWithFormat:@"%@ %@ %@ %@",list.data.province,list.data.city,list.data.area,list.data.address];
            }
            top.merchant_name.text = list.data.merchant_name;
            if ([list.data.sum_discount floatValue] < 0.01) {
                _sum_discount.hidden = YES;
            }
            _sum_discount.text = [NSString stringWithFormat:@"总抵扣金额￥%@",list.data.sum_discount];
            _sum_shop_price.text = [NSString stringWithFormat:@"￥%.2f",[list.data.sum_shop_price floatValue]];
            
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data.item];
                [_mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.item.count) {
                    
                    [arr addObjectsFromArray:list.data.item];
                    [_mTable.mj_footer endRefreshing];
                    
                } else {
                    
                    [_mTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [_mTable.mj_header endRefreshing];
            [_mTable reloadData];
            for (SAuctionOrderShoppingCart * list_split in arr) {
                NSMutableDictionary * dic_split = [[NSMutableDictionary alloc] init];
                [dic_split setValue:list_split.goods_id forKey:@"goods_id"];
                [dic_split setValue:list_split.num forKey:@"num"];
                [split_arr addObject:dic_split];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else if ([_special_type isEqualToString:@"无界商店"]) {
        SIntegralBuyOrderShoppingCart * list = [[SIntegralBuyOrderShoppingCart alloc] init];
        list.merchant_id = _merchant_id;
        list.integralBuy_id = _integralBuy_id;
        list.num = _num;
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sIntegralBuyOrderShoppingCartSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SIntegralBuyOrderShoppingCart * list = (SIntegralBuyOrderShoppingCart *)data;
            if ([list.data.is_default isEqualToString:@"0"] || list.data.is_default == nil) {
                [top.addressBtn setTitle:@"请选择收货地址" forState:UIControlStateNormal];
            } else {
                [top.addressBtn setTitle:@"" forState:UIControlStateNormal];
                model_address_id = list.data.address_id;
                top.receiver.text = [NSString stringWithFormat:@"收货人:%@",list.data.receiver];
                top.phone.text = list.data.phone;
                top.address.text = [NSString stringWithFormat:@"%@ %@ %@ %@",list.data.province,list.data.city,list.data.area,list.data.address];
            }
            top.merchant_name.text = list.data.merchant_name;
//            if ([list.data.sum_discount floatValue] < 0.01) {
                _sum_discount.hidden = YES;
//            }
//            _sum_discount.text = [NSString stringWithFormat:@"总抵扣金额￥%@",list.data.sum_discount];
            _sum_shop_price.text = [NSString stringWithFormat:@"%.2f积分", [list.data.sum_shop_price floatValue]];
            
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data.item];
                [_mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.item.count) {
                    
                    [arr addObjectsFromArray:list.data.item];
                    [_mTable.mj_footer endRefreshing];
                    
                } else {
                    
                    [_mTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [_mTable.mj_header endRefreshing];
            [_mTable reloadData];
            for (SIntegralBuyOrderShoppingCart * list_split in arr) {
                NSMutableDictionary * dic_split = [[NSMutableDictionary alloc] init];
                [dic_split setValue:list_split.goods_id forKey:@"goods_id"];
                [dic_split setValue:list_split.num forKey:@"num"];
                [split_arr addObject:dic_split];
            }
            
            /*
             *进口税税金的显示
             */
            CGFloat countrynum = 0;//进口税金额
            for (SIntegralBuyOrderShoppingCart * list_split in arr) {
                countrynum += [list_split.country_tax floatValue];
            }
            if (countrynum < 0.01) {
                _country_tax.text = @"";
            } else {
                _country_tax.text = [NSString stringWithFormat:@"+%.2f进口税",countrynum];
            }

            
            /*
             *获取无界商店确认订单中的商品的购买积分
             */
            if ([_special_type isEqualToString:@"无界商店"]) {
                SIntegralBuyOrderShoppingCart * list_split = arr.firstObject;
                model_use_integral = list_split.use_integral;
            }
            
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    else if ([_special_type isEqualToString:@"赠品专区"]) {
        SgiftShoppingCartModel * list = [[SgiftShoppingCartModel alloc] init];
        list.giftGoods_id = _giftGoods_id;
        list.address_id=model_address_id.length>0 ? model_address_id :@""  ;
        list.num = _num;
        [MBProgressHUD showMessage:nil toView:self.view];
        [list SgiftShoppingCartModelSuccess:^(NSString *  code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SgiftShoppingCartModel * list = (SgiftShoppingCartModel *)data;
            if ([list.data.is_default isEqualToString:@"0"] || list.data.is_default == nil) {
                [top.addressBtn setTitle:@"请选择收货地址" forState:UIControlStateNormal];
            } else {
                [top.addressBtn setTitle:@"" forState:UIControlStateNormal];
                model_address_id = list.data.address_id;
                top.receiver.text = [NSString stringWithFormat:@"收货人:%@",list.data.receiver];
                top.phone.text = list.data.phone;
                top.address.text = [NSString stringWithFormat:@"%@ %@ %@ %@",list.data.province,list.data.city,list.data.area,list.data.address];
            }
            top.merchant_name.text = list.data.merchant_name;
            //            if ([list.data.sum_discount floatValue] < 0.01) {
            _sum_discount.hidden = YES;
          
            _sum_shop_price.text = [NSString stringWithFormat:@"%.2f赠品券", [list.data.sum_shop_price floatValue]];
            
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data.item];
                [_mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.item.count) {
                    
                    [arr addObjectsFromArray:list.data.item];
                    [_mTable.mj_footer endRefreshing];
                    
                } else {
                    
                    [_mTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [_mTable.mj_header endRefreshing];
            [_mTable reloadData];
            for (SgiftShoppingCartModel * list_split in arr) {
                NSMutableDictionary * dic_split = [[NSMutableDictionary alloc] init];
                [dic_split setValue:list_split.goods_id forKey:@"goods_id"];
                [dic_split setValue:list_split.num forKey:@"num"];
                [split_arr addObject:dic_split];
            }
            
            /*
             *进口税税金的显示
             */
            CGFloat countrynum = 0;//进口税金额
            for (SgiftShoppingCartModel * list_split in arr) {
                countrynum += [list_split.country_tax floatValue];
            }
            if (countrynum < 0.01) {
                _country_tax.text = @"";
            } else {
                _country_tax.text = [NSString stringWithFormat:@"+%.2f进口税",countrynum];
            }
            
            
//            /*
//             *获取无界商店确认订单中的商品的购买积分
//             */
//            if ([_special_type isEqualToString:@"无界商店"]) {
//                SgiftShoppingCartModel * list_split = arr.firstObject;
//                model_use_integral = list_split.use_voucher;
//            }
            
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    else if ([_special_type isEqualToString:@"寄售管理"]) {
        CleanConfirmOrderModel  *list=[[CleanConfirmOrderModel alloc]init];
        list.goods_id=_goods_id;
        list.num=_num;
        list.product_id=_product_id;
        list.order_id=_order_id;
        [list CleanConfirmOrderModelSuccess:^(NSString * _Nonnull code, NSString * _Nonnull message, id  _Nonnull data) {
             arr = [NSMutableArray arrayWithArray:list.data.item];
     
            [_mTable reloadData];
        } andFailure:^(NSError * _Nonnull error) {
            
        }];

    }
    
    else {
        //普通商品、限量购、进口馆、票券区
        SOrderShoppingCart * list = [[SOrderShoppingCart alloc] init];
        list.cart_id = _cart_id == nil ? @"" : _cart_id;
        list.merchant_id = _merchant_id;
        list.p = @"1";
        if (_cart_id != nil) {
            list.goods = @"";
            list.order_type = @"0";
        } else {
            if (_goods_Json != nil) {
                list.goods = _goods_Json;
                list.order_type = @"4";
            } else {
                list.order_type = @"0";
                NSMutableArray * json_arr = [[NSMutableArray alloc] init];
                NSMutableDictionary * json_dic = [[NSMutableDictionary alloc] init];
                [json_dic setValue:_goods_id forKey:@"goods_id"];
                if (_product_id != nil) {
                    [json_dic setValue:_product_id forKey:@"product_id"];
                }
                [json_arr addObject:json_dic];
                list.goods = [json_arr mj_JSONString];
            }
        }
        list.num = _num == nil ? @"" : _num;
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sOrderShoppingCartSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SOrderShoppingCart * list = (SOrderShoppingCart *)data;
            //   [list.data.is_active isEqualToString:@"3"]
            if ([list.data.is_default isEqualToString:@"0"] || list.data.is_default == nil) {
                [top.addressBtn setTitle:@"请选择收货地址" forState:UIControlStateNormal];
            } else {
                [top.addressBtn setTitle:@"" forState:UIControlStateNormal];
                model_address_id = list.data.address_id;
                top.receiver.text = [NSString stringWithFormat:@"收货人:%@",list.data.receiver];
                top.phone.text = list.data.phone;
                top.address.text = [NSString stringWithFormat:@"%@ %@ %@ %@",list.data.province,list.data.city,list.data.area,list.data.address];
            }
            top.merchant_name.text = list.data.merchant_name;
            if ([list.data.sum_discount floatValue] < 0.01) {
                _sum_discount.hidden = YES;
            }
            _sum_discount.text = [NSString stringWithFormat:@"总抵扣金额￥%@",list.data.sum_discount];
            _sum_shop_price.text = [NSString stringWithFormat:@"￥%.2f",[list.data.sum_shop_price floatValue]];
            
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data.item];
                [_mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.item.count) {
                    
                    [arr addObjectsFromArray:list.data.item];
                    [_mTable.mj_footer endRefreshing];
                    
                } else {
                    
                    [_mTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [_mTable.mj_header endRefreshing];
            [_mTable reloadData];
            for (SOrderShoppingCart * list_split in arr) {
                NSMutableDictionary * dic_split = [[NSMutableDictionary alloc] init];
                [dic_split setValue:list_split.goods_id forKey:@"goods_id"];
                [dic_split setValue:list_split.num forKey:@"num"];
                [split_arr addObject:dic_split];
            }
            
            CGFloat countrynum = 0;//进口税金额
            for (SOrderShoppingCart * list in arr) {
                countrynum += [list.country_tax floatValue];
            }
            if (countrynum < 0.01) {
                _country_tax.text = @"";
            } else {
                _country_tax.text = [NSString stringWithFormat:@"+%.2f进口税",countrynum];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
  
}
- (void)viewDidAppear:(BOOL)animated {
    if (firstComing == NO) {
        firstComing = YES;
    } else {
        SAddressAddressList * list = [[SAddressAddressList alloc] init];
        list.p = @"1";
        [list sAddressAddressListSuccess:^(NSString *code, NSString *message, id data) {
            SAddressAddressList * list = (SAddressAddressList *)data;
            if ([list.data.default_address.receiver isEqualToString:@""] && list.data.common_address.count == 0) {
                [top.addressBtn setTitle:@"请选择收货地址" forState:UIControlStateNormal];
                model_address_id = nil;
                top.receiver.text = @"";
                top.phone.text = @"";
                top.address.text = @"";
            }
        } andFailure:^(NSError *error) {
        }];
    }
}
- (void)createNav {
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"黑色返回"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    
    [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)lefthBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 选择地址
- (void)addressBtnClick {
    SAddress * address = [[SAddress alloc] init];
    address.choice_isno = YES;
    [self.navigationController pushViewController:address animated:YES];
    address.SAddress_Choice = ^(NSString *province, NSString *city, NSString *area, NSString *address, NSString *address_id, NSString *receiver, NSString *phone) {
        model_address_id = address_id;
        top.receiver.text = [NSString stringWithFormat:@"收货人:%@",receiver];
        top.phone.text = phone;
        top.address.text = [NSString stringWithFormat:@"%@ %@ %@ %@",province,city,area,address];
        [top.addressBtn setTitle:@"" forState:UIControlStateNormal];
        
        for (SOrderShoppingCart * list in arr) {
            list.send_name = nil;
            list.send_company = nil;
            list.send_price = nil;
            list.tem_id = nil;
            list.type_status = nil;
            list.shipping_id = nil;
        }
        [_mTable reloadData];
        _send_price.text = @"";
    };
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return arr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    SOrderShoppingCart * list = arr[section];
    NSInteger list_height = 350;
    /******
     ****** 下方属性没有 通过拼单进来后 此属性没有
     ********/
    if ([list.invoice_status integerValue] == 0) {
        list_height -= 50;
    }
    if ([list.after_sale_status integerValue] == 0) {
        list_height -= 50;
    }
    if ([list.is_welfare integerValue] == 0) {
        list_height -= 50;
    }
    if ([list.integrity_a isEqualToString:@""]) {
        list_height -= 50;
    }
    if ([list.integrity_b isEqualToString:@""]) {
        list_height -= 50;
    }
    if ([list.integrity_c isEqualToString:@""]) {
        list_height -= 50;
    }
    return list_height;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {

    if (_order_id.length==0) {
        SOrderShoppingCart * list = arr[section];
        
        SOrderConfirm_footer * footer = [[SOrderConfirm_footer alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 350)];
        
        //快递类型
        [footer.sendBtn addTarget:self action:@selector(sendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [footer.sendBtn setTag:section];
        /******
         ****** list.send_name 通过拼单进来后 此属性没有
         ********/
        if (list.send_name == nil) {
            footer.sendTitle.text = @"请选择配送方式";
        } else {
            footer.sendTitle.text = @"配送方式：";
            if ([list.send_price isEqualToString:@"0"]) {
                footer.sendType.text = [NSString stringWithFormat:@"%@(%@) 包邮",list.send_name,list.send_company];
            } else {
                footer.sendType.text = [NSString stringWithFormat:@"%@(%@) ￥%@",list.send_name,list.send_company,list.send_price];
            }
        }
        
        //是否显示发票模块
        if ([list.invoice_status integerValue] == 1) {
            footer.invoiceView.hidden = NO;
            footer.invoiceView_HHH.constant = 50;
            [footer.invoiceBtn addTarget:self action:@selector(invoiceBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            [footer.invoiceBtn setTag:section];
            if (list.is_invoice == nil) {
                footer.thisType.text = @"不开发票";
            } else {
                footer.thisType.text = list.invoice_type;
            }
        } else {
            footer.invoiceView.hidden = YES;
            footer.invoiceView_HHH.constant = 0;
        }
        
        //是否显示售后服务
        if ([list.after_sale_status integerValue] == 1) {
            footer.serviceView.hidden = NO;
            footer.serviceView_HHH.constant = 50;
            footer.after_sale_service.text = list.after_sale_type;
        } else {
            footer.serviceView.hidden = YES;
            footer.serviceView_HHH.constant = 0;
        }
        
        //是否显示公益宝贝模块
        if ([list.is_welfare integerValue] == 1) {
            footer.welfareView.hidden = NO;
            footer.welfareView_HHH.constant = 50;
            footer.welfare.text = [NSString stringWithFormat:@"成交后卖家将捐款%@元给公益计划",list.welfare];
        } else {
            footer.welfareView.hidden = YES;
            footer.welfareView_HHH.constant = 0;
        }
        
        //是否显示特殊描述
        if ([list.integrity_a isEqualToString:@""]) {
            footer.integrity_aView.hidden = YES;
            footer.integrity_aViewHHH.constant = 0;
        } else {
            footer.integrity_aView.hidden = NO;
            footer.integrity_aViewHHH.constant = 50;
            footer.integrity_a.text = list.integrity_a;
        }
        
        if ([list.integrity_b isEqualToString:@""]) {
            footer.integrity_bView.hidden = YES;
            footer.integrity_bView_HHH.constant = 0;
        } else {
            footer.integrity_bView.hidden = NO;
            footer.integrity_bView_HHH.constant = 50;
            footer.integrity_b.text = list.integrity_b;
        }
        if ([list.integrity_c isEqualToString:@""]) {
            footer.integrity_cView.hidden = YES;
            footer.integrity_cView_HHH.constant = 0;
        } else {
            footer.integrity_cView.hidden = NO;
            footer.integrity_cView_HHH.constant = 50;
            footer.integrity_c.text = list.integrity_c;
        }
        
        return footer;
    }
    return nil;
   

}
#pragma mark - 选择商品快递类型
- (void)sendBtnClick:(UIButton *)btn {
    if (model_address_id == nil) {
        [MBProgressHUD showError:@"请添加地址" toView:self.view];
        return;
    }
    SOrderSend * send = [[SOrderSend alloc] init];
    send.modalPresentationStyle = UIModalPresentationOverFullScreen;
    send.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:send animated:YES completion:nil];
    SOrderShoppingCart * list = arr[btn.tag];
    
    NSMutableArray * nowArr = [[NSMutableArray alloc] init];
    for (SOrderShoppingCart * nowList in arr) {
        NSMutableDictionary * nowDic = [[NSMutableDictionary alloc] init];
        [nowDic setValue:nowList.goods_id forKey:@"goods_id"];
        [nowDic setValue:nowList.product_id forKey:@"product_id"];
        [nowDic setValue:nowList.num forKey:@"goods_num"];
        [nowArr addObject:nowDic];
    }
    [send showModel_andGoods_id:list.goods_id andAddress_id:model_address_id andGoods_info:[nowArr mj_JSONString]];
    send.SOrderSendBack = ^(NSString *name, NSString *name_price, NSString *tem_id, NSString *type_status, NSString *shipping_id, NSString *shipping_name, NSString * same_tem_id, NSString * desc, NSString * type) {
        _shipping_id = shipping_id;
        for (NSString * str in [same_tem_id componentsSeparatedByString:@","]) {
            for (SOrderShoppingCart * nowList in arr) {
                if ([nowList.goods_id isEqualToString:str]) {
                    nowList.send_name = name;
                    nowList.send_company = shipping_name;
                    nowList.send_price = name_price;
                    nowList.tem_id = tem_id;
                    nowList.type_status = type_status;
                    nowList.shipping_id = shipping_id;
                    nowList.desc = desc;
                    nowList.type = type;
                    nowList.same_tem_id = same_tem_id;
                }
            }
        }
        [_mTable reloadData];
        
        NSMutableArray * same_arr_one = [[NSMutableArray alloc] init];
        for (SOrderShoppingCart * list in arr) {
            if (list.same_tem_id != nil) {
                [same_arr_one addObject:list.same_tem_id];
            }
        }
        NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
        for (unsigned i = 0; i < same_arr_one.count; i++){
            if ([categoryArray containsObject:same_arr_one[i]] == NO){
                [categoryArray addObject:same_arr_one[i]];
            }
        }
        CGFloat sendnum = 0;//快递金额
        for (SOrderShoppingCart * list in arr) {
            if ([categoryArray containsObject:list.same_tem_id]) {
                sendnum += [list.send_price floatValue];
                [categoryArray removeObject:list.same_tem_id];
            }
        }
        if (sendnum < 0.01) {
            _send_price.text = @"包邮";
        } else {
            
            /*
             *  fxg 无界商店 元运费 → 积分
             */
            if ([_special_type isEqualToString:@"无界商店"]) {
              _send_price.text = [NSString stringWithFormat:@"+%.2f积分",sendnum];
            }else{
                _send_price.text = [NSString stringWithFormat:@"+%.2f元运费",sendnum];
            }
            
        }
    };
}
#pragma mark - 发票类型选择
- (void)invoiceBtnClick:(UIButton *)btn {
    SOrderShoppingCart * list = arr[btn.tag];
    SOrderConfirmInvoice * invoice = [[SOrderConfirmInvoice alloc] init];
    invoice.goods_id = list.goods_id;
    invoice.num = list.num;
    invoice.product_id = list.product_id;
    
    /*
     *无界商店的商品发票价格的计算根据商品使用的积分计算
     */
    invoice.shop_Price = model_use_integral;
    invoice.special_type = self.special_type;
    
    invoice.now_invoice_type = list.invoice_type;
    invoice.now_t_id = list.t_id;
    invoice.now_rise = list.rise;
    invoice.now_rise_name = list.rise_name;
    invoice.now_invoice_detail = list.invoice_detail;
    invoice.now_invoice_id = list.invoice_id;
    invoice.now_recognition = list.recognition;
    invoice.now_is_invoice = list.is_invoice;
    invoice.now_express_fee = list.express_fee;
    invoice.now_tax = list.tax;
    invoice.now_tax_pay = list.tax_pay;
    invoice.now_explain = list.explain;
    
    [self.navigationController pushViewController:invoice animated:YES];
    
    invoice.SOrderConfirmInvoice_choice = ^(NSString * invoice_type, NSString *t_id, NSString *rise, NSString *rise_name, NSString *invoice_detail, NSString *invoice_id, NSString *recognition, NSString *is_invoice, NSString *express_fee, NSString *tax_pay, NSString * tax, NSString * explain) {
        if (is_invoice == nil || [is_invoice isEqualToString:@"0"]) {
            list.invoice_type = @"不开发票";
            list.tax_pay = @"";
            list.express_fee = @"";
            list.tax = @"";
        } else {
            list.invoice_type = invoice_type;
            list.tax_pay = tax_pay;
            list.express_fee = express_fee;
            list.tax = tax;
        }
        list.t_id = t_id;
        list.rise = rise;
        list.rise_name = rise_name;
        list.invoice_detail = invoice_detail;
        list.invoice_id = invoice_id;
        list.recognition = recognition;
        list.is_invoice = is_invoice;
        list.explain = explain;
        [_mTable reloadData];
        
        CGFloat num1 = 0.0;
        CGFloat num2 = 0.0;
        for (SOrderShoppingCart * all in arr) {
            if (list.is_invoice != nil || ![list.is_invoice isEqualToString:@"0"]) {
                num1 += [all.tax_pay floatValue];
                num2 += [all.express_fee floatValue];
            }
        }
        if (num1 < 0.01) {
            _alltax_pay.text = @"";
        } else {
            _alltax_pay.text = [NSString stringWithFormat:@"+%.2f税费",num1];
        }
        if (num1 < 0.01) {
            _express_fee.text = @"";
        } else {
            _express_fee.text = [NSString stringWithFormat:@"+%.2f发票运费",num2];
        }
        if ([_alltax_pay.text isEqualToString:@""] && [_express_fee.text isEqualToString:@""]) {
            _send_price_HHH.constant = 50;
        } else {
            _send_price_HHH.constant = 25;
        }
    };
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SOrderConfirm_goodsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SOrderConfirm_goodsCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"  %@",@"标题标题标题标题标题标题标题标题标题标题标题标题标题标题"]];
//
//    //图文混排
//    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
//    textAttachment.image = [UIImage imageNamed:@"拼团R"];
//
//    textAttachment.bounds = CGRectMake(0, -8, 25, 25);
//    // 用textAttachment生成属性字符串
//    NSAttributedString *attachmentAttrStr = [NSAttributedString attributedStringWithAttachment:textAttachment];
//    // 属性字符串插入到目标字符串
//    [AttributedStr insertAttributedString:attachmentAttrStr atIndex:0];
//    cell.thisTitle.attributedText = AttributedStr;
    
    
    if ([_special_type isEqualToString:@"拼单购"]) {
        SGroupBuyOrderShoppingCart * list = arr[indexPath.section];
        [cell.goods_img sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.thisTitle.text = list.goods_name;
        cell.shop_price.text = [NSString stringWithFormat:@"￥%@",list.shop_price];
        cell.num.text = [NSString stringWithFormat:@"x%@",list.num];
        cell.goods_attr.text = list.goods_attr_first;
    } else if ([_special_type isEqualToString:@"无界预购"]) {
        SPreOrderPreShoppingCart * list = arr[indexPath.section];
        [cell.goods_img sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.thisTitle.text = list.goods_name;
        cell.shop_price.text = [NSString stringWithFormat:@"￥%@",list.shop_price];
        cell.num.text = [NSString stringWithFormat:@"x%@",list.num];
        cell.goods_attr.text = list.goods_attr_first;
    } else if ([_special_type isEqualToString:@"限量购"]) {
        SLimitBuyOrderShoppingCart * list = arr[indexPath.section];
        [cell.goods_img sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.thisTitle.text = list.goods_name;
        cell.shop_price.text = [NSString stringWithFormat:@"￥%@",list.shop_price];
        cell.num.text = [NSString stringWithFormat:@"x%@",list.num];
        cell.goods_attr.text = list.goods_attr_first;
    } else if ([_special_type isEqualToString:@"积分抽奖"]) {
        SIntegralOrderShoppingCart * list = arr[indexPath.section];
        [cell.goods_img sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.thisTitle.text = list.goods_name;
        cell.shop_price.text = [NSString stringWithFormat:@"￥%@",list.shop_price];
        cell.num.text = [NSString stringWithFormat:@"x%@",list.num];
        cell.goods_attr.text = list.goods_attr_first;
    } else if ([_special_type isEqualToString:@"比价购"]) {
        SAuctionOrderShoppingCart * list = arr[indexPath.section];
        [cell.goods_img sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.thisTitle.text = list.goods_name;
        cell.shop_price.text = [NSString stringWithFormat:@"￥%@",list.shop_price];
        cell.num.text = [NSString stringWithFormat:@"x%@", list.num];
        cell.goods_attr.text = list.goods_attr_first;
    } else if ([_special_type isEqualToString:@"无界商店"]) {
        SIntegralBuyOrderShoppingCart * list = arr[indexPath.section];
        [cell.goods_img sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.thisTitle.text = list.goods_name;
        //shop_price → use_integral by_fxg
        cell.shop_price.text = [NSString stringWithFormat:@"%@积分",list.use_integral];
        cell.num.text = [NSString stringWithFormat:@"x%@", list.num];
        cell.goods_attr.text = list.goods_attr_first;
    }
    else if ([_special_type isEqualToString:@"赠品专区"]) {
        SgiftShoppingCartModel * list = arr[indexPath.section];
        [cell.goods_img sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.thisTitle.text = list.goods_name;
        //shop_price → use_integral by_fxg
        cell.shop_price.text = [NSString stringWithFormat:@"%@赠品券",list.use_voucher];
        cell.num.text = [NSString stringWithFormat:@"x%@", list.num];
        cell.goods_attr.text = list.goods_attr_first;
    }
    
    else {
        SOrderShoppingCart * list = arr[indexPath.section];
        [cell.goods_img sd_setImageWithURL:[NSURL URLWithString:list.goods_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        cell.thisTitle.text = list.goods_name;
        cell.shop_price.text = [NSString stringWithFormat:@"￥%@",list.shop_price];
        cell.num.text = [NSString stringWithFormat:@"x%@",list.num];
        
        if([list.is_active isEqualToString:@"3"]){
            cell.goods_attr.text = @"";
            is_active = list.is_active;
            cell.view_2980.hidden=NO;
            cell.lab_2980.text=@"2980";
           
        }else{
            cell.view_2980.hidden=YES;
           // NSLog(@"SSSSS %@",list.return_integral);
            if (list.return_integral == nil || [list.return_integral isEqualToString:@""]||[list.return_integral doubleValue]==0) {
                cell.goods_attr.text = list.goods_attr_first;
            } else {
                NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@(赠送:%@积分)",list.goods_attr_first,list.return_integral]];
                [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(list.goods_attr_first.length , 7 + list.return_integral.length)];
                cell.goods_attr.attributedText = AttributedStr;
                is_active = @"";
            }
        }
    }
    return cell;
}
#pragma mark - 支付
- (void)submitBtnClick {
    if (model_address_id == nil) {
        [MBProgressHUD showError:@"请添加地址" toView:self.view];
        return;
    }
    SPay * pay = [[SPay alloc] init];
    if (_special_type == nil) {
        pay.model_type = @"普通商品";
        
    } else if ([_special_type isEqualToString:@"拼单购"]) {
        pay.model_type = @"拼单购";
    } else if ([_special_type isEqualToString:@"无界预购"]) {
        pay.model_type = @"无界预购";
    } else if ([_special_type isEqualToString:@"积分抽奖"]) {
        pay.model_type = @"积分抽奖";
    } else if ([_special_type isEqualToString:@"比价购"]) {
        pay.model_type = @"比价购";
    } else if ([_special_type isEqualToString:@"无界商店"]) {
        pay.model_type = @"无界商店";
    }
    else if ([_special_type isEqualToString:@"赠品专区"]) {
        pay.model_type = @"赠品专区";
        
    }
    pay.address_id = model_address_id;
    pay.goods_num = _num;
    pay.goods_id = _goods_id;
    pay.product_id = _product_id;
    
    //拼单购所需参数
    pay.special_type_sub = _special_type_sub;
    pay.group_buy_id = _group_buy_id;
    pay.group_buy_order_id = _group_buy_order_id;
    pay.shipping_id = _shipping_id;
    
    //无界预购所需参数
    pay.pre_id = _pre_id;
    //积分抽奖所需参数
    pay.integral_id = _integral_id;
    //比价购所需参数
    pay.auction_id = _auction_id;
    pay.auction_isno = _auction_isno;
    //无界商店
    pay.integralBuy_id = _integralBuy_id;
    
//    //快递信息
//    if ([top.sendType.text isEqualToString:@""]) {
//        [MBProgressHUD showError:@"请选择配送方式" toView:self.view];
//        return;
//    }
//    pay.freight_type = top.sendType.text;
//    pay.freight = chice_freight;
    
    //搭配购模式
    pay.goods_Json = _goods_Json;
    
    if (_special_type == nil || [_special_type isEqualToString:@"拼单购"] || [_special_type isEqualToString:@"无界商店"]||[_special_type isEqualToString:@"赠品专区"]) {
        //发票参数
        NSMutableArray * invoiceArr = [[NSMutableArray alloc] init];
        //快递类型参数
        if ([self send_isno] == NO) {
            [MBProgressHUD showError:@"请选择所有商品的配送方式" toView:self.view];
            return;
        }
        NSMutableArray * goodsArr = [[NSMutableArray alloc] init];
        for (SOrderShoppingCart * list in arr) {
            //发票参数
            NSMutableDictionary * invoiceDic = [[NSMutableDictionary alloc] init];
            //快递类型参数
            NSMutableDictionary * goodsDic = [[NSMutableDictionary alloc] init];

            //发票参数
            [invoiceDic setValue:list.t_id == nil ? @"" : list.t_id forKey:@"t_id"];
            [invoiceDic setValue:list.rise == nil ? @"" : list.rise forKey:@"rise"];
            [invoiceDic setValue:list.rise_name == nil ? @"" : list.rise_name forKey:@"rise_name"];
            [invoiceDic setValue:list.invoice_detail == nil ? @"" : list.invoice_detail forKey:@"invoice_detail"];
            [invoiceDic setValue:list.invoice_id == nil ? @"" : list.invoice_id forKey:@"invoice_id"];
            [invoiceDic setValue:list.recognition == nil ? @"" : list.recognition forKey:@"recognition"];
            [invoiceDic setValue:list.is_invoice == nil ? @"" : list.is_invoice forKey:@"is_invoice"];
            [invoiceArr addObject:invoiceDic];
            //快递类型参数
            if (_cart_id == nil) {
                //单商品直接购买
                [goodsDic setValue:list.product_id == nil ? @"" : list.product_id forKey:@"product_id"];
                [goodsDic setValue:list.goods_id == nil ? @"" : list.goods_id forKey:@"goods_id"];
                [goodsDic setValue:list.num == nil ? @"" : list.num forKey:@"num"];
            } else {
                //购物车多商品下单购买
                [goodsDic setValue:list.cart_id == nil ? @"" : list.cart_id forKey:@"cate_ids"];
            }
            [goodsDic setValue:list.tem_id == nil ? @"" : list.tem_id forKey:@"tem_id"];
            [goodsDic setValue:list.type_status == nil ? @"" : list.type_status forKey:@"type_status"];
            [goodsDic setValue:list.shipping_id == nil ? @"" : list.shipping_id forKey:@"shipping_id"];
            [goodsDic setValue:list.send_price == nil ? @"" : list.send_price forKey:@"pay"];
            [goodsDic setValue:list.type == nil ? @"" : list.type forKey:@"type"];
            [goodsDic setValue:list.desc == nil ? @"" : list.desc forKey:@"desc"];
            [goodsDic setValue:list.same_tem_id == nil ? @"" : list.same_tem_id forKey:@"same_tem_id"];
            [goodsDic setValue:list.send_company == nil ? @"" : list.send_company forKey:@"send_company"];
            [goodsArr addObject:goodsDic];
        }
        NSLog(@"___ %@____ %@",goodsArr,invoiceArr);
        pay.invoice = [invoiceArr mj_JSONString];
        pay.goods = [goodsArr mj_JSONString];
        
    }
    if ([down.leave_messageTV.text isEqualToString:@"选填：填写内容已和卖家协商确认"]) {
        pay.leave_message = @"";
    } else {
        pay.leave_message = down.leave_messageTV.text;
    }
    
    pay.is_active = is_active;

    [self.navigationController pushViewController:pay animated:YES];
}
#pragma mark - 判断快递是否全部选择了
- (BOOL)send_isno {
    for (SOrderShoppingCart * list in arr) {
        if (list.send_name == nil) {
            return NO;
        }
    }
    return YES;
}
@end
