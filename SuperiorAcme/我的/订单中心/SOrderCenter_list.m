//
//  SOrderCenter_list.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOrderCenter_list.h"
#import "SNPageView.h"
#import "SOrderCenter_listView.h"
#import "SOrderCenter_list_Auction.h"
#import "SOrderInfor.h"
#import "SEvaSubmit.h"
#import "SCarOrderOrderList.h"//汽车购订单列表
#import "SCarConfirm.h"//汽车购订单详情
#import "SHouse_Map.h"
#import "SPay.h"
#import "SEvaCar.h"
#import "SHouseOrderOrderList.h"//房产购订单列表
#import "SHouseConfirm.h"//房产购订单详情

#import "SCarOrderCancelOrder.h"//汽车购取消订单
#import "SHouseOrderCancelOrder.h"//房产购取消订单

#import "SCarOrderDeleteOrder.h"//汽车购删除订单
#import "SHouseOrderDeleteOrder.h"//房产购删除订单

#import "SOrderOrderList.h"//普通商品订单列表
#import "SOrderCancelOrder.h"//普通商品取消订单
#import "SOrderReceiving.h"//普通商品确认收货
#import "SOrderDeleteOrder.h"//普通商品删除订单

#import "SGroupBuyOrderOrderList.h"//拼单购订单列表
#import "SGroupBuyOrderCancelOrder.h"//拼单购取消订单
#import "SGroupBuyOrderDeleteOrder.h"//拼单购删除订单
#import "SGroupBuyOrderReceiving.h"//拼单购确认收货

#import "SPreOrderPreOrderList.h"//无界预购订单列表
#import "SPreOrderPreCancelOrder.h"//无界预购取消订单
#import "SPreOrderPreDeleteOrder.h"//无界预购删除订单
#import "SPreOrderPreReceiving.h"//无界预购确认收货

#import "SAuctionOrderOrderList.h"//比价购订单列表
#import "SAuctionOrderCancelOrder.h"//比价购取消订单
#import "SAuctionOrderDeleteOrder.h"//比价购删除订单
#import "SAuctionOrderReceiving.h"//比价购确认收货
#import "SOrderConfirm.h"//比价购竞拍付尾款

#import "SIntegralBuyOrderOrderList.h"//无界商店订单列表
#import "SIntegralBuyOrderCancelOrder.h"//无界商店取消订单
#import "SIntegralBuyOrderDeleteOrder.h"//无界商店删除订单
#import "SIntegralBuyOrderReceiving.h"//无界商店确认收货

#import "SOnlineShopInfor.h"//店铺详情
#import "SPay_Pass.h"//收货验证

#import "SFightGroups.h"
#import "SgiftOderListModel.h"
#import "SgiftCancelOrderModel.h"
#import "SgiftOderReceivingModel.h"
#import "SgiftDeleteOder.h"
@interface SOrderCenter_list ()
{
    SOrderCenter_listView * listView;
    NSMutableArray * arr;//列表
    NSInteger  page;
    NSString * car_type;//汽车购、房产购：订单状态 ( 1全部 2待付款 3办手续中 4待评价 )
    NSString * order_status;//普通商品：订单状态（9''默认全部' 0': '待支付‘ ； '1': '待发货' ； '2': '待收货' ；'3': '待评价'；'4': '已完成）
    NSString * order_status_Group;//（'0': '待付款‘ ； '1': '待成团' ； '2': '待发货' ；'3': '待收货'；'4': '待评价 5 已完成 6取消 9全部 7待抽奖  10未中奖 8未成团)
    NSString * order_status_Pre;// '0': '预购中' ； '1': '待付尾款' ；'2': '待发货；'3': '待收货；‘4’：待评价；‘5’：‘已取消’；‘6’：已完成；‘7’ ：待付定金） 默认9（全部）
    NSString * order_status_Auc;//订单状态 订单状态 竞拍中=>10; 竞拍成功=>11; 竞拍结束=>12; 待付款=>1;待发货=>3; 待收货=>4; 待评价=>8 ; 已完成=>6; 已取消=>5; 全部订单=>9

    BOOL firstBegin;//如果不是第一次进来就要刷新数据
    ///哈哈哈哈
    
}
@end

@implementation SOrderCenter_list

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    if ([_type isEqualToString:@"1"]) {
         self.title = @"线上商城";
    } else if ([_type isEqualToString:@"2"]) {
        self.title = @"拼单购";
    } else if ([_type isEqualToString:@"3"]) {
        self.title = @"无界预购";
    } else if ([_type isEqualToString:@"4"]) {
        self.title = @"比价购";
    } else if ([_type isEqualToString:@"5"]) {
        self.title = @"汽车购";
    } else if ([_type isEqualToString:@"6"]) {
        self.title = @"房产购";
    } else if ([_type isEqualToString:@"7"]) {
        self.title = @"积分商店";
    }
    else if ([_type isEqualToString:@"12"]) {
        self.title = @"399专区";
    }
    else if ([_type isEqualToString:@"15"]) {
        self.title = @"赠品专区";
    }
    else if ([_type isEqualToString:@"16"]) {
        self.title = @"集碎片";
    }
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
}
- (void)viewDidAppear:(BOOL)animated {
    if (firstBegin == YES) {
        [self showModel];
    }
    if (firstBegin == NO) {
        firstBegin = YES;//再次返回要刷新数据了
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    SNPageView * pageView = [[SNPageView alloc] initWithFrame:CGRectMake(0, 64.5, ScreenW, ScreenH - 64.5) p_style:PageViewStyleLine];
    if ([_type isEqualToString:@"1"] || [_type isEqualToString:@"4"] || [_type isEqualToString:@"7"]||[_type isEqualToString:@"12"]||[_type isEqualToString:@"16"]) {
        pageView.subViews = @[[SOrderCenter_listView class],[SOrderCenter_listView class],[SOrderCenter_listView class],[SOrderCenter_listView class],[SOrderCenter_listView class]];
        pageView.titles = @[@"全部",@"待付款",@"待发货",@"待收货",@"待评价"];
        pageView.titleWidth = [UIScreen mainScreen].bounds.size.width/5;
    }
    else if ([_type isEqualToString:@"15"]) {
        pageView.subViews = @[[SOrderCenter_listView class],[SOrderCenter_listView class],[SOrderCenter_listView class],[SOrderCenter_listView class],[SOrderCenter_listView class]];
        pageView.titles = @[@"全部",@"待付款",@"待发货",@"待收货"];
        pageView.titleWidth = [UIScreen mainScreen].bounds.size.width/5;
    }
    
    else if ([_type isEqualToString:@"2"]) {
        pageView.subViews = @[[SOrderCenter_listView class],[SOrderCenter_listView class],[SOrderCenter_listView class],[SOrderCenter_listView class],[SOrderCenter_listView class],[SOrderCenter_listView class],[SOrderCenter_listView class],[SOrderCenter_listView class],[SOrderCenter_listView class]];
        pageView.titles = @[@"全部",@"待抽奖",@"未中奖",@"待付款",@"拼单中",@"待发货",@"待收货",@"待评价",@"未拼成"];
        pageView.titleWidth = [UIScreen mainScreen].bounds.size.width/5.5;
    } else if ([_type isEqualToString:@"3"]) {
        pageView.subViews = @[[SOrderCenter_listView class],[SOrderCenter_listView class],[SOrderCenter_listView class],[SOrderCenter_listView class],[SOrderCenter_listView class],[SOrderCenter_listView class]];
        pageView.titles = @[@"全部",@"预购中",@"待付尾款",@"待发货",@"待收货",@"待评价"];
        pageView.titleWidth = [UIScreen mainScreen].bounds.size.width/6;
    } else if ([_type isEqualToString:@"5"] || [_type isEqualToString:@"6"]) {
        pageView.subViews = @[[SOrderCenter_listView class],[SOrderCenter_listView class],[SOrderCenter_listView class],[SOrderCenter_listView class]];
        pageView.titles = @[@"全部",@"待付款",@"办理手续中",@"待评价"];
        pageView.titleWidth = [UIScreen mainScreen].bounds.size.width/4;
    }
    pageView.titleSelectedFont = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    pageView.sliderColor = WordColor;
    pageView.defaultSelectedIndex = 0;
    pageView.topTitleViewColor = [UIColor whiteColor];
    pageView.goundNormalColor = [UIColor whiteColor];
    __block SOrderCenter_list * gSelf = self;
    [pageView showInView:self.view action:^(id subView, UIButton *btn, NSInteger index) {
        if (index == 0) {
            listView = subView;
            car_type = @"1";
            order_status = @"9";
            order_status_Group = @"9";
            order_status_Pre = @"9";
            order_status_Auc = @"9";
        } else if (index == 1) {
            listView = subView;
            car_type = @"2";
          
            order_status = @"0";
           
           
            order_status_Group = @"7";
            order_status_Pre = @"0";
            order_status_Auc = @"1";

        } else if (index == 2) {
            listView = subView;
            car_type = @"3";
                order_status = @"1";
            order_status_Group = @"10";
            order_status_Pre = @"1";
            order_status_Auc = @"3";
        } else if (index == 3) {
            listView = subView;
            car_type = @"4";
           
              order_status = @"2";
            
            order_status_Group = @"0";
            order_status_Pre = @"2";
            order_status_Auc = @"4";
        } else if (index == 4) {
            listView = subView;
            order_status = @"3";
            order_status_Group = @"1";
            order_status_Pre = @"3";
            order_status_Auc = @"8";
        } else if (index == 5) {
            listView = subView;
            order_status_Group = @"2";
            order_status_Pre = @"4";
        } else if (index == 6) {
            listView = subView;
            order_status_Group = @"3";
            order_status_Pre = @"4";
        } else if (index == 7) {
            listView = subView;
            order_status_Group = @"4";
            order_status_Pre = @"4";
        } else if (index == 8) {
            listView = subView;
            order_status_Group = @"8";
            order_status_Pre = @"4";
        }
        page = 1;
        [self initRefresh];
        [self showModel];
        listView.SOrderCenter_listView_map = ^(NSString *shop_name, NSString *lng, NSString *lat) {
            if ([lng isEqualToString:@"普通商品"]) {
                SOnlineShopInfor * infor = [[SOnlineShopInfor alloc] init];
                infor.merchant_id = shop_name;
                infor.hidesBottomBarWhenPushed = YES;
                [gSelf.navigationController pushViewController:infor animated:YES];
            } else {
                //汽车购、房产购
                SHouse_Map * map = [[SHouse_Map alloc] init];
                map.model_lng = lng;
                map.model_lat = lat;
                map.model_houseName = shop_name;
                [gSelf.navigationController pushViewController:map animated:YES];
            }
            
        };
        listView.SOrderCenter_listView_infor = ^(NSString *order_id,NSString * order_type) {
          
            if ([_type isEqualToString:@"5"]) {
                //汽车购详情
                SCarConfirm * infor = [[SCarConfirm alloc] init];
                infor.infor_isno = YES;
                infor.order_id = order_id;
                [gSelf.navigationController pushViewController:infor animated:YES];
                
            } else if ([_type isEqualToString:@"6"]) {
                //房产购详情
                SHouseConfirm * infor = [[SHouseConfirm alloc] init];
                infor.infor_isno = YES;
                infor.order_id = order_id;
                [gSelf.navigationController pushViewController:infor animated:YES];

            } else {
                SOrderInfor * infor = [[SOrderInfor alloc] init];
                if ([_type isEqualToString:@"1"]|| [_type isEqualToString:@"12"]|| [_type isEqualToString:@"16"]) {
                    //普通商品
                    infor.order_type = @"普通商品";
                    
                    if ([order_type isEqualToString:@"13"]) {

                        infor.Is_2980=YES;
                    }
                    if ([order_type isEqualToString:@"12"]) {
                        
                        infor.IsInShop=YES;
                    }
                    if ([order_type isEqualToString:@"16"]) {
                        
                        infor.IsSuiPian=YES;
                    }
                } else if ([_type isEqualToString:@"2"]) {
                    //拼单购
                    if ([listView.list_group_orders_status isEqualToString:@"1"] && ![listView.group_buy_type_status isEqualToString:@"1"]) {
                        //待成团
                        SFightGroups * join = [[SFightGroups alloc] init];
                        join.group_buy_order_id = listView.p_id;
                        join.group_buy_type_status = listView.group_buy_type_status;//可能用不上
                        join.GivenIntegral = listView.GivenIntegral;
                        join.hidesBottomBarWhenPushed = YES;
                        [self.navigationController pushViewController:join animated:YES];
                        return;
                    }
                    infor.order_type = @"拼单购";
                } else if ([_type isEqualToString:@"3"]) {
                    //无界预购
                    infor.order_type = @"无界预购";
                } else if ([_type isEqualToString:@"4"]) {
                    //比价购
                    infor.order_type = @"比价购";
                } else if ([_type isEqualToString:@"7"]) {
                    //无界商店
                    infor.order_type = @"无界商店";
                }
                else if ([_type isEqualToString:@"15"])
                {
                   infor.order_type = @"赠品专区";
                }
                
                infor.order_id = order_id;
                [gSelf.navigationController pushViewController:infor animated:YES];
            }
            
        };
        listView.SOrderCenter_listView_oneBtn = ^(UIButton *btn, NSString *order_id,NSString *goods_id) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"取消订单?" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"点击取消");
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"点击确定");
                if ([_type isEqualToString:@"1"]||[_type isEqualToString:@"12"]||[_type isEqualToString:@"16"]) {
                    //普通商品取消订单
                    SOrderCancelOrder * cancel_order = [[SOrderCancelOrder alloc] init];
                    cancel_order.order_id = order_id;
                    [MBProgressHUD showMessage:nil toView:self.view];
                    [cancel_order sOrderCancelOrderSuccess:^(NSString *code, NSString *message) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        if ([code isEqualToString:@"1"]) {
                            [MBProgressHUD showSuccess:message toView:self.view];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                page=1;
                                [gSelf showModel];
                            });
                        } else {
                            [MBProgressHUD showError:message toView:self.view];
                        }
                    } andFailure:^(NSError *error) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                    }];
                } else if ([_type isEqualToString:@"2"]) {
                    //拼单购取消订单
                    SGroupBuyOrderCancelOrder * cancel_order = [[SGroupBuyOrderCancelOrder alloc] init];
                    cancel_order.group_buy_order_id = order_id;
                    [MBProgressHUD showMessage:nil toView:self.view];
                    [cancel_order sGroupBuyOrderCancelOrderSuccess:^(NSString *code, NSString *message) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        if ([code isEqualToString:@"1"]) {
                            [MBProgressHUD showSuccess:message toView:self.view];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                 page=1;
                                [gSelf showModel];
                            });
                        } else {
                            [MBProgressHUD showError:message toView:self.view];
                        }
                    } andFailure:^(NSError *error) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                    }];
                    
                }  else if ([_type isEqualToString:@"3"]) {
                    //无界预购取消订单
                    SPreOrderPreCancelOrder * cancel_order = [[SPreOrderPreCancelOrder alloc] init];
                    cancel_order.order_id = order_id;
                    [MBProgressHUD showMessage:nil toView:self.view];
                    [cancel_order sPreOrderPreCancelOrderSuccess:^(NSString *code, NSString *message) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        if ([code isEqualToString:@"1"]) {
                            [MBProgressHUD showSuccess:message toView:self.view];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                 page=1;
                                [gSelf showModel];
                            });
                        } else {
                            [MBProgressHUD showError:message toView:self.view];
                        }
                    } andFailure:^(NSError *error) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                    }];
                    
                }  else if ([_type isEqualToString:@"4"]) {
                    //比价购取消订单
                    SAuctionOrderCancelOrder * cancel_order = [[SAuctionOrderCancelOrder alloc] init];
                    cancel_order.order_id = order_id;
                    [MBProgressHUD showMessage:nil toView:self.view];
                    [cancel_order sAuctionOrderCancelOrderSuccess:^(NSString *code, NSString *message) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        if ([code isEqualToString:@"1"]) {
                            [MBProgressHUD showSuccess:message toView:self.view];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                 page=1;
                                [gSelf showModel];
                            });
                        } else {
                            [MBProgressHUD showError:message toView:self.view];
                        }
                    } andFailure:^(NSError *error) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                    }];
                    
                } if ([_type isEqualToString:@"5"]) {
                    //汽车购取消订单
                    SCarOrderCancelOrder * cancel_order = [[SCarOrderCancelOrder alloc] init];
                    cancel_order.order_id = order_id;
                    [MBProgressHUD showMessage:nil toView:self.view];
                    [cancel_order sCarOrderCancelOrderSuccess:^(NSString *code, NSString *message) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        if ([code isEqualToString:@"1"]) {
                            [MBProgressHUD showSuccess:message toView:self.view];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                 page=1;
                                [gSelf showModel];
                            });
                        } else {
                            [MBProgressHUD showError:message toView:self.view];
                        }
                    } andFailure:^(NSError *error) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                    }];
                } else if ([_type isEqualToString:@"6"]) {
                    //房产购取消订单
                    SHouseOrderCancelOrder * cancel_order = [[SHouseOrderCancelOrder alloc] init];
                    cancel_order.order_id = order_id;
                    [MBProgressHUD showMessage:nil toView:self.view];
                    [cancel_order sHouseOrderCancelOrderSuccess:^(NSString *code, NSString *message) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        if ([code isEqualToString:@"1"]) {
                            [MBProgressHUD showSuccess:message toView:self.view];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                 page=1;
                                [gSelf showModel];
                            });
                        } else {
                            [MBProgressHUD showError:message toView:self.view];
                        }
                    } andFailure:^(NSError *error) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                    }];
                } else if ([_type isEqualToString:@"7"]) {
                    //无界商店取消订单
                    SIntegralBuyOrderCancelOrder * cancel_order = [[SIntegralBuyOrderCancelOrder alloc] init];
                    cancel_order.order_id = order_id;
                    [MBProgressHUD showMessage:nil toView:self.view];
                    [cancel_order sIntegralBuyOrderCancelOrderSuccess:^(NSString *code, NSString *message) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        if ([code isEqualToString:@"1"]) {
                            [MBProgressHUD showSuccess:message toView:self.view];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                 page=1;
                                [gSelf showModel];
                            });
                        } else {
                            [MBProgressHUD showError:message toView:self.view];
                        }
                    } andFailure:^(NSError *error) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                    }];
                }
                else if ([_type isEqualToString:@"15"]) {
                    SgiftCancelOrderModel * cancel_order = [[SgiftCancelOrderModel alloc] init];
                    cancel_order.order_id = order_id;
                    [MBProgressHUD showMessage:nil toView:self.view];
                    [cancel_order SgiftCancelOrderModelSuccess:^(NSString *code, NSString *message) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        if ([code isEqualToString:@"200"]) {
                            [MBProgressHUD showSuccess:message toView:self.view];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                 page=1;
                                [gSelf showModel];
                            });
                        } else {
                            [MBProgressHUD showError:message toView:self.view];
                        }
                    } andFailure:^(NSError *error) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                    }];
                }
                
                
            }]];
            [gSelf presentViewController:alertController animated:YES completion:nil];
        };
        listView.SOrderCenter_listView_twoBtn = ^(UIButton *btn, NSString * order_id, NSString * group_buy_id, NSString * order_type, NSString * shop_price, NSString * pic) {
            if ([btn.titleLabel.text isEqualToString:@"付款"]) {
                
                SPay * pay = [[SPay alloc] init];
                if ([_type isEqualToString:@"1"]||[_type isEqualToString:@"12"]||[_type isEqualToString:@"16"]) {
                    pay.model_type = @"普通商品";
                    //2980
                    if ([order_type isEqualToString:@"13"]) {
                        pay.is_active=@"3";
                    }
                    //399商品
                    if ([order_type isEqualToString:@"12"]) {
                        pay.IsInShop=YES;
                    }
                    if ([order_type isEqualToString:@"16"]) {
                        pay.IsSuiPian=YES;
                    }
                } else if ([_type isEqualToString:@"2"]) {
                    pay.model_type = @"拼单购";
                    pay.group_buy_id = group_buy_id;
                    pay.group_buy_order_id = order_id;
                    pay.special_type_sub = @"4";
                    //为了不让goods为空造成crash 添加以下代码
                    NSMutableDictionary *goodsDic = [NSMutableDictionary dictionary];
                    NSMutableArray *goodsArr = [NSMutableArray array];
                    [goodsDic setValue:shop_price forKey:@"pay"];
                    [goodsDic setValue:pic forKey:@"send_company"];
                    [goodsArr addObject:goodsDic];
                    pay.goods = [goodsArr mj_JSONString];
                    
                } else if ([_type isEqualToString:@"3"]) {
                    pay.model_type = @"无界预购";
                } else if ([_type isEqualToString:@"4"]) {
                    pay.model_type = @"比价购";
                    if ([order_type isEqualToString:@"1"]) {
                        //竞拍
                        SOrderConfirm * com = [[SOrderConfirm alloc] init];
                        com.order_id = order_id;
                        [gSelf.navigationController pushViewController:com animated:YES];
                        return ;
                    } else {
                        //一口价
                        pay.auction_isno = YES;
                        
                    }
                } else if ([_type isEqualToString:@"5"]) {
                    pay.model_type = @"汽车购";
                } else if ([_type isEqualToString:@"6"]) {
                    pay.model_type = @"房产购";
                } else if ([_type isEqualToString:@"7"]) {
                    pay.model_type = @"无界商店";
                    //为了不让goods为空造成crash 添加以下代码
                    NSMutableDictionary *goodsDic = [NSMutableDictionary dictionary];
                    NSMutableArray *goodsArr = [NSMutableArray array];
                    [goodsDic setValue:shop_price forKey:@"pay"];
                    [goodsDic setValue:pic forKey:@"send_company"];
                    [goodsArr addObject:goodsDic];
                    pay.goods = [goodsArr mj_JSONString];
                }
                else if ([_type isEqualToString:@"15"]) {
                    pay.model_type = @"赠品专区";
                    //为了不让goods为空造成crash 添加以下代码
                    NSMutableDictionary *goodsDic = [NSMutableDictionary dictionary];
                    NSMutableArray *goodsArr = [NSMutableArray array];
                    [goodsDic setValue:shop_price forKey:@"pay"];
                    [goodsDic setValue:pic forKey:@"send_company"];
                    [goodsArr addObject:goodsDic];
                    pay.goods = [goodsArr mj_JSONString];
                }
                
                
                
                pay.order_id = order_id;
                [gSelf.navigationController pushViewController:pay animated:YES];
            }
            if ([btn.titleLabel.text isEqualToString:@"评价"]) {
                if ([_type isEqualToString:@"5"]) {
                    //汽车购评价
                    SEvaCar * carEva = [[SEvaCar alloc] init];
                    carEva.type = @"汽车购";
                    carEva.order_id = order_id;
                    [gSelf.navigationController pushViewController:carEva animated:YES];
                } else if ([_type isEqualToString:@"6"]) {
                    //房产购评价
                    SEvaCar * carEva = [[SEvaCar alloc] init];
                    carEva.type = @"房产购";
                    carEva.order_id = order_id;
                    [gSelf.navigationController pushViewController:carEva animated:YES];
                } else {
                    SEvaSubmit * evaSubmit = [[SEvaSubmit alloc] init];
                    evaSubmit.order_id = order_id;
                    if ([_type isEqualToString:@"1"]||[_type isEqualToString:@"12"]) {
                        evaSubmit.order_type = @"普通商品";
                    } else if ([_type isEqualToString:@"2"]) {
                        evaSubmit.order_type = @"拼单购";
                    } else if ([_type isEqualToString:@"3"]) {
                        evaSubmit.order_type = @"无界预购";
                    } else if ([_type isEqualToString:@"4"]) {
                        evaSubmit.order_type = @"比价购";
                    } else if ([_type isEqualToString:@"7"]) {
                        evaSubmit.order_type = @"无界商店";
                    }
                    else if ([_type isEqualToString:@"15"]) {
                        evaSubmit.order_type = @"赠品专区";
                    }
                    else if ([_type isEqualToString:@"16"]) {
                        evaSubmit.order_type = @"集碎片";
                    }
                    [gSelf.navigationController pushViewController:evaSubmit animated:YES];
                }
            }
            if ([btn.titleLabel.text isEqualToString:@"确认收货"]) {
                if ([_type isEqualToString:@"1"]||[_type isEqualToString:@"12"]|| [_type isEqualToString:@"16"]) {
                    SPay_Pass * pass = [[SPay_Pass alloc] init];
                    pass.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
                    pass.modalPresentationStyle = UIModalPresentationOverFullScreen;
                    [self.navigationController presentViewController:pass animated:YES completion:nil];
                    pass.SPay_Pass_back = ^{
                        //普通商品确认收货
                        SOrderReceiving * receiving = [[SOrderReceiving alloc] init];
                        receiving.order_id = order_id;
                        [MBProgressHUD showMessage:nil toView:self.view];
                        [receiving sOrderReceivingSuccess:^(NSString *code, NSString *message) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            if ([code isEqualToString:@"1"]) {
                                [MBProgressHUD showSuccess:message toView:self.view];
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                     page=1;
                                    [gSelf showModel];
                                });
                            } else {
                                [MBProgressHUD showError:message toView:self.view];
                            }
                        } andFailure:^(NSError *error) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                        }];
                    };
                } else if ([_type isEqualToString:@"2"]) {
                    //拼单购确认收货
                    SGroupBuyOrderReceiving * receiving = [[SGroupBuyOrderReceiving alloc] init];
                    receiving.group_buy_order_id = order_id;
                    [MBProgressHUD showMessage:nil toView:self.view];
                    [receiving sGroupBuyOrderReceivingSuccess:^(NSString *code, NSString *message) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        if ([code isEqualToString:@"1"]) {
                            [MBProgressHUD showSuccess:message toView:self.view];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                 page=1;
                                [gSelf showModel];
                            });
                        } else {
                            [MBProgressHUD showError:message toView:self.view];
                        }
                    } andFailure:^(NSError *error) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                    }];
                } else if ([_type isEqualToString:@"3"]) {
                    //无界预购确认收货
                    SPreOrderPreReceiving * receiving = [[SPreOrderPreReceiving alloc] init];
                    receiving.order_id = order_id;
                    [MBProgressHUD showMessage:nil toView:self.view];
                    [receiving sPreOrderPreReceivingSuccess:^(NSString *code, NSString *message) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        if ([code isEqualToString:@"1"]) {
                            [MBProgressHUD showSuccess:message toView:self.view];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                 page=1;
                                [gSelf showModel];
                            });
                        } else {
                            [MBProgressHUD showError:message toView:self.view];
                        }
                    } andFailure:^(NSError *error) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                    }];
                } else if ([_type isEqualToString:@"4"]) {
                    //比价购确认收货
                    SAuctionOrderReceiving * receiving = [[SAuctionOrderReceiving alloc] init];
                    receiving.order_id = order_id;
                    [MBProgressHUD showMessage:nil toView:self.view];
                    [receiving sAuctionOrderReceivingSuccess:^(NSString *code, NSString *message) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        if ([code isEqualToString:@"1"]) {
                            [MBProgressHUD showSuccess:message toView:self.view];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                 page=1;
                                [gSelf showModel];
                            });
                        } else {
                            [MBProgressHUD showError:message toView:self.view];
                        }
                    } andFailure:^(NSError *error) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                    }];
                } else if ([_type isEqualToString:@"7"]) {
                    //无界商店确认收货
                    SIntegralBuyOrderReceiving * receiving = [[SIntegralBuyOrderReceiving alloc] init];
                    receiving.order_id = order_id;
                    [MBProgressHUD showMessage:nil toView:self.view];
                    [receiving sIntegralBuyOrderReceivingSuccess:^(NSString *code, NSString *message) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        if ([code isEqualToString:@"1"]) {
                            [MBProgressHUD showSuccess:message toView:self.view];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                 page=1;
                                [gSelf showModel];
                            });
                        } else {
                            [MBProgressHUD showError:message toView:self.view];
                        }
                    } andFailure:^(NSError *error) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                    }];
                }
                else if ([_type isEqualToString:@"15"]) {
                    SgiftOderReceivingModel * receiving = [[SgiftOderReceivingModel alloc] init];
                    receiving.order_id = order_id;
                    receiving.status=@"1";
                    [MBProgressHUD showMessage:nil toView:self.view];
                    [receiving SgiftOderReceivingModelSuccess:^(NSString *code, NSString *message) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        if ([code isEqualToString:@"200"]) {
                            [MBProgressHUD showSuccess:message toView:self.view];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                     page=1;
                                     [gSelf showModel];
                                });
                            });
                        } else {
                            [MBProgressHUD showError:message toView:self.view];
                        }
                    } andFailure:^(NSError *error) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                    }];
                }
            }
            if ([btn.titleLabel.text isEqualToString:@"删除订单"]) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除订单?" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    NSLog(@"点击取消");
                }]];
                [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSLog(@"点击确定");
                    
                    if ([_type isEqualToString:@"1"]||[_type isEqualToString:@"12"]|| [_type isEqualToString:@"16"]) {
                        //普通商品删除订单
                        SOrderDeleteOrder * cancel_order = [[SOrderDeleteOrder alloc] init];
                        cancel_order.order_id = order_id;
                        [MBProgressHUD showMessage:nil toView:self.view];
                        [cancel_order sOrderDeleteOrderSuccess:^(NSString *code, NSString *message) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            if ([code isEqualToString:@"1"]) {
                                [MBProgressHUD showSuccess:message toView:self.view];
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                     page=1;
                                    [gSelf showModel];
                                });
                            } else {
                                [MBProgressHUD showError:message toView:self.view];
                            }
                        } andFailure:^(NSError *error) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                        }];
                    } else if ([_type isEqualToString:@"2"]) {
                        //拼单购删除订单
                        SGroupBuyOrderDeleteOrder * cancel_order = [[SGroupBuyOrderDeleteOrder alloc] init];
                        cancel_order.group_buy_order_id = order_id;
                        [MBProgressHUD showMessage:nil toView:self.view];
                        [cancel_order sGroupBuyOrderDeleteOrderSuccess:^(NSString *code, NSString *message) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            if ([code isEqualToString:@"1"]) {
                                [MBProgressHUD showSuccess:message toView:self.view];
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                     page=1;
                                    [gSelf showModel];
                                });
                            } else {
                                [MBProgressHUD showError:message toView:self.view];
                            }
                        } andFailure:^(NSError *error) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                        }];
                    } else if ([_type isEqualToString:@"3"]) {
                        //无界预购删除订单
                        SPreOrderPreDeleteOrder * cancel_order = [[SPreOrderPreDeleteOrder alloc] init];
                        cancel_order.order_id = order_id;
                        [MBProgressHUD showMessage:nil toView:self.view];
                        [cancel_order sPreOrderPreDeleteOrderSuccess:^(NSString *code, NSString *message) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            if ([code isEqualToString:@"1"]) {
                                [MBProgressHUD showSuccess:message toView:self.view];
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                     page=1;
                                    [gSelf showModel];
                                });
                            } else {
                                [MBProgressHUD showError:message toView:self.view];
                            }
                        } andFailure:^(NSError *error) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                        }];
                    } else if ([_type isEqualToString:@"4"]) {
                        //比价购删除订单
                        SAuctionOrderDeleteOrder * cancel_order = [[SAuctionOrderDeleteOrder alloc] init];
                        cancel_order.order_id = order_id;
                        [MBProgressHUD showMessage:nil toView:self.view];
                        [cancel_order sAuctionOrderDeleteOrderSuccess:^(NSString *code, NSString *message) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            if ([code isEqualToString:@"1"]) {
                                [MBProgressHUD showSuccess:message toView:self.view];
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                     page=1;
                                    [gSelf showModel];
                                });
                            } else {
                                [MBProgressHUD showError:message toView:self.view];
                            }
                        } andFailure:^(NSError *error) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                        }];
                    } else if ([_type isEqualToString:@"5"]) {
                        //汽车购删除订单
                        SCarOrderDeleteOrder * cancel_order = [[SCarOrderDeleteOrder alloc] init];
                        cancel_order.order_id = order_id;
                        [MBProgressHUD showMessage:nil toView:self.view];
                        [cancel_order sCarOrderDeleteOrderSuccess:^(NSString *code, NSString *message) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            if ([code isEqualToString:@"1"]) {
                                [MBProgressHUD showSuccess:message toView:self.view];
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                     page=1;
                                    [gSelf showModel];
                                });
                            } else {
                                [MBProgressHUD showError:message toView:self.view];
                            }
                        } andFailure:^(NSError *error) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                        }];
                    } else if ([_type isEqualToString:@"6"]) {
                        //房产购删除订单
                        SHouseOrderDeleteOrder * cancel_order = [[SHouseOrderDeleteOrder alloc] init];
                        cancel_order.order_id = order_id;
                        [MBProgressHUD showMessage:nil toView:self.view];
                        [cancel_order sHouseOrderDeleteOrderSuccess:^(NSString *code, NSString *message) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            if ([code isEqualToString:@"1"]) {
                                [MBProgressHUD showSuccess:message toView:self.view];
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                     page=1;
                                    [gSelf showModel];
                                });
                            } else {
                                [MBProgressHUD showError:message toView:self.view];
                            }
                        } andFailure:^(NSError *error) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                        }];
                    } else if ([_type isEqualToString:@"7"]) {
                        //无界商店删除订单
                        SIntegralBuyOrderDeleteOrder * cancel_order = [[SIntegralBuyOrderDeleteOrder alloc] init];
                        cancel_order.order_id = order_id;
                        [MBProgressHUD showMessage:nil toView:self.view];
                        [cancel_order sIntegralBuyOrderDeleteOrderSuccess:^(NSString *code, NSString *message) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            if ([code isEqualToString:@"1"]) {
                                [MBProgressHUD showSuccess:message toView:self.view];
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                     page=1;
                                    [gSelf showModel];
                                });
                            } else {
                                [MBProgressHUD showError:message toView:self.view];
                            }
                        } andFailure:^(NSError *error) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                        }];
                    }
                    else if ([_type isEqualToString:@"15"]) {
                        //无界商店删除订单
                        SgiftDeleteOder * cancel_order = [[SgiftDeleteOder alloc] init];
                        cancel_order.order_id =order_id;
                        [MBProgressHUD showMessage:nil toView:self.view];
                        [cancel_order SgiftDeleteOderModelSuccess:^(NSString *code, NSString *message) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            if ([code isEqualToString:@"200"]) {
                                [MBProgressHUD showSuccess:message toView:self.view];
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                     page=1;
                                    
                                    [gSelf showModel];
                                });
                            } else {
                                [MBProgressHUD showError:message toView:self.view];
                            }
                        } andFailure:^(NSError *error) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                        }];
                    }
                    
                    
                }]];
                [gSelf presentViewController:alertController animated:YES completion:nil];
            }
        };
    }];
}
- (void)initRefresh
{
    __block SOrderCenter_list * blockSelf = self;
    listView.mTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        page = 1;
        [blockSelf showModel];
        
    }];
    listView.mTable.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        page++;
        [blockSelf showModel];
    }];
}
- (void)showModel {
    if ([_type isEqualToString:@"1"]||[_type isEqualToString:@"12"]||[_type isEqualToString:@"16"]) {
        //普通商品
        SOrderOrderList * list = [[SOrderOrderList alloc] init];
        list.order_status = order_status;
        if ([_type isEqualToString:@"12"]) {
             list.order_type = @"12";
        }
        else if ([_type isEqualToString:@"16"])
        {
            list.order_type = @"16";
        }
        else
        {
             list.order_type = @"0";
        }
       
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sOrderOrderListSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SOrderOrderList * list = (SOrderOrderList *)data;
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data];
                [listView.mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.count) {
                    [arr addObjectsFromArray:list.data];
                    [listView.mTable.mj_footer endRefreshing];
                } else {
                    [listView.mTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [listView showCarModel:arr andType:@"普通商品"];
            [listView.mTable.mj_header endRefreshing];
            [listView.mTable reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
        
    } else if ([_type isEqualToString:@"2"]) {
        //拼单购
        SGroupBuyOrderOrderList * list = [SGroupBuyOrderOrderList alloc];
        list.order_status = order_status_Group;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sGroupBuyOrderOrderListSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SGroupBuyOrderOrderList * list = (SGroupBuyOrderOrderList *)data;
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data];
                [listView.mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.count) {
                    [arr addObjectsFromArray:list.data];
                    [listView.mTable.mj_footer endRefreshing];
                } else {
                    [listView.mTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [listView showCarModel:arr andType:@"拼单购"];
            [listView.mTable.mj_header endRefreshing];
            [listView.mTable reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
        
    } else if ([_type isEqualToString:@"3"]) {
        //无界预购
        SPreOrderPreOrderList * list = [SPreOrderPreOrderList alloc];
        list.order_status = order_status_Pre;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sPreOrderPreOrderListSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SPreOrderPreOrderList * list = (SPreOrderPreOrderList *)data;
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data];
                [listView.mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.count) {
                    [arr addObjectsFromArray:list.data];
                    [listView.mTable.mj_footer endRefreshing];
                } else {
                    [listView.mTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [listView showCarModel:arr andType:@"无界预购"];
            [listView.mTable.mj_header endRefreshing];
            [listView.mTable reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else if ([_type isEqualToString:@"4"]) {
        //比价购
        SAuctionOrderOrderList * list = [SAuctionOrderOrderList alloc];
        list.order_status = order_status_Auc;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sAuctionOrderOrderListSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SAuctionOrderOrderList * list = (SAuctionOrderOrderList *)data;
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data];
                [listView.mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.count) {
                    [arr addObjectsFromArray:list.data];
                    [listView.mTable.mj_footer endRefreshing];
                } else {
                    [listView.mTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [listView showCarModel:arr andType:@"比价购"];
            [listView.mTable.mj_header endRefreshing];
            [listView.mTable reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else if ([_type isEqualToString:@"5"]) {
        //汽车购
        SCarOrderOrderList * list = [[SCarOrderOrderList alloc] init];
        list.type = car_type;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sCarOrderOrderListSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SCarOrderOrderList * list = (SCarOrderOrderList *)data;
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data];
                [listView.mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.count) {
                    [arr addObjectsFromArray:list.data];
                    [listView.mTable.mj_footer endRefreshing];
                } else {
                    [listView.mTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [listView showCarModel:arr andType:@"汽车购"];
            [listView.mTable.mj_header endRefreshing];
            [listView.mTable reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else if ([_type isEqualToString:@"6"]) {
        //房产购
        SHouseOrderOrderList * list = [[SHouseOrderOrderList alloc] init];
        list.type = car_type;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sHouseOrderOrderListSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SHouseOrderOrderList * list = (SHouseOrderOrderList *)data;
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data];
                [listView.mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.count) {
                    [arr addObjectsFromArray:list.data];
                    [listView.mTable.mj_footer endRefreshing];
                } else {
                    [listView.mTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [listView showCarModel:arr andType:@"房产购"];
            [listView.mTable.mj_header endRefreshing];
            [listView.mTable reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else if ([_type isEqualToString:@"7"]) {
        //无界商店
        SIntegralBuyOrderOrderList * list = [SIntegralBuyOrderOrderList alloc];
        list.order_status = order_status;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sIntegralBuyOrderOrderListSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SIntegralBuyOrderOrderList * list = (SIntegralBuyOrderOrderList *)data;
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data];
                [listView.mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.count) {
                    [arr addObjectsFromArray:list.data];
                    [listView.mTable.mj_footer endRefreshing];
                } else {
                    [listView.mTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [listView showCarModel:arr andType:@"无界商店"];
            [listView.mTable.mj_header endRefreshing];
            [listView.mTable reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    else if ([_type isEqualToString:@"15"]) {
      
        SgiftOderListModel * list = [SgiftOderListModel alloc];
        list.order_status = order_status;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list SgiftOderListModelSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SgiftOderListModel * list = (SgiftOderListModel *)data;
            if (page == 1) {
                arr = [NSMutableArray arrayWithArray:list.data];
                [listView.mTable.mj_footer resetNoMoreData];
            } else {
                if (list.data.count) {
                    [arr addObjectsFromArray:list.data];
                    [listView.mTable.mj_footer endRefreshing];
                } else {
                    [listView.mTable.mj_footer endRefreshingWithNoMoreData];
                }
            }
            [listView showCarModel:arr andType:@"赠品专区"];
            [listView.mTable.mj_header endRefreshing];
            [listView.mTable reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
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
    
    if ([_type isEqualToString:@"4"]) {
        UIButton * rigthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rigthBtn.frame = CGRectMake(0, 0, 70, 50);
        UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rigthBtn];
        self.navigationItem.rightBarButtonItem = rightItem;
        
        [rigthBtn setTitle:@"比价纪录" forState:UIControlStateNormal];
        rigthBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [rigthBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [rigthBtn addTarget:self action:@selector(rigthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
}
- (void)lefthBtnClick {
    if (_coming == YES) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        /*
         *添加退出团购订单列表时,发出的通知消息,目的是当退出由直接支付团购订单列表的界面的时候,关闭拼团倒计时的定时器
         */
        [[NSNotificationCenter defaultCenter] postNotificationName:@"QuitGroupBuyOrderListFromPay" object:nil userInfo:nil];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
- (void)rigthBtnClick {
    //竞拍汇
    SOrderCenter_list_Auction * auction = [[SOrderCenter_list_Auction alloc] init];
    [self.navigationController pushViewController:auction animated:YES];
}

@end
