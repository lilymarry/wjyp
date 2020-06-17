//
//  SOrderCenter_list_Auction.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOrderCenter_list_Auction.h"
#import "SNPageView.h"
#import "SOrderCenter_listView.h"
#import "SOrderCenter_list_Auction_infor.h"
#import "SIntegralOrderOrderList.h"
#import "SPay.h"
#import "SIntegralOrderDeleteOrder.h"
#import "SShopCar_editView.h"
#import "SAuctionOrderOrderList.h"//比价购订单列表
#import "SOrderInfor.h"

@interface SOrderCenter_list_Auction ()
{
    SOrderCenter_listView * listView;
    NSMutableArray * arr;//列表
    NSInteger  page;
    
    NSString * order_status_Integral;//积分抽奖
    NSString * order_status_Auc;//比价购
    BOOL firstBegin;
}
@end

@implementation SOrderCenter_list_Auction
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
    if (_type == NO) {
        pageView.subViews = @[[SOrderCenter_listView class],[SOrderCenter_listView class],[SOrderCenter_listView class]];
        pageView.titles = @[@"竞拍中",@"竞拍成功",@"竞拍结束"];
        pageView.titleWidth = [UIScreen mainScreen].bounds.size.width/3;
    } else {
        pageView.subViews = @[[SOrderCenter_listView class],[SOrderCenter_listView class],[SOrderCenter_listView class],[SOrderCenter_listView class]];
        pageView.titles = @[@"全部",@"进行中",@"已揭晓",@"中奖记录"];
        pageView.titleWidth = [UIScreen mainScreen].bounds.size.width/4;
    }
    pageView.titleSelectedFont = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    pageView.sliderColor = WordColor;
    pageView.defaultSelectedIndex = 0;
    pageView.topTitleViewColor = [UIColor whiteColor];
    pageView.goundNormalColor = [UIColor whiteColor];
    [pageView showInView:self.view action:^(id subView, UIButton *btn, NSInteger index) {

        if (index == 0) {
            listView = subView;
            order_status_Integral = @"9";
            order_status_Auc = @"10";
        } else if (index == 1) {
            listView = subView;
            order_status_Integral = @"10";
            order_status_Auc = @"11";
        } else if (index == 2) {
            listView = subView;
            order_status_Integral = @"11";
            order_status_Auc = @"12";
        } else if (index == 3) {
            listView = subView;
            order_status_Integral = @"12";
        }
        if (_type == NO) {
            //比价购纪录
            listView.SOrderCenter_listView_twoBtn = ^(UIButton *btn, NSString *order_id, NSString *group_buy_id, NSString *order_type, NSString *shop_price, NSString *pic) {
                SOrderInfor * infor = [[SOrderInfor alloc] init];
                //比价购
                infor.order_type = @"比价购纪录";
                infor.order_id = order_id;
                [self.navigationController pushViewController:infor animated:YES];
            };
        } else {
            //积分抽奖
            listView.SOrderCenter_listView_twoBtn = ^(UIButton *btn, NSString *order_id, NSString *group_buy_id, NSString *order_type, NSString * shop_price, NSString * pic) {
                if ([btn.titleLabel.text isEqualToString:@"追加"]) {
                    
                    SShopCar_editView * editView = [[SShopCar_editView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
                    [[[UIApplication sharedApplication] keyWindow] addSubview:editView];
                    editView.scr_HHH.constant = ScreenH;
                    editView.goods_id = group_buy_id;
                    editView.product_id = order_type;
                    [editView showModel];
                    [editView addBuy:@"立即购买"];//立即购买
                    
                    editView.SShopCar_editView_back = ^{
                        [editView removeFromSuperview];
                    };
                    //立即购买
                    editView.SShopCar_editView_addBuy = ^(NSString *num, NSString *now_product_id) {
                        [editView removeFromSuperview];
                        SPay * pay = [[SPay alloc] init];
                        pay.model_type =  @"积分抽奖";
                        pay.order_id = order_id;
                        pay.add_integral_isno = YES;
                        pay.goods_num = num;
                        pay.product_id = now_product_id;
                        [self.navigationController pushViewController:pay animated:YES];
                    };
                    
                    
                    
                } else {
                    //删除
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除订单?" preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        NSLog(@"点击取消");
                    }]];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        NSLog(@"点击确定");
                        
                        SIntegralOrderDeleteOrder * cancel_order = [[SIntegralOrderDeleteOrder alloc] init];
                        cancel_order.order_id = order_id;
                        [MBProgressHUD showMessage:nil toView:self.view];
                        [cancel_order sIntegralOrderDeleteOrderSuccess:^(NSString *code, NSString *message) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            if ([code isEqualToString:@"1"]) {
                                [MBProgressHUD showSuccess:message toView:self.view];
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    [self showModel];
                                });
                            } else {
                                [MBProgressHUD showError:message toView:self.view];
                            }
                        } andFailure:^(NSError *error) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                        }];
                        
                    }]];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
            };
            listView.SOrderCenter_listView_infor = ^(NSString *order_id,NSString *is_2980) {
                SOrderCenter_list_Auction_infor * infor = [[SOrderCenter_list_Auction_infor alloc] init];
                infor.order_id = order_id;
                [self.navigationController pushViewController:infor animated:YES];
            };
        }
        page = 1;
        [self initRefresh];
        [self showModel];
    }];
}
- (void)initRefresh
{
    __block SOrderCenter_list_Auction * blockSelf = self;
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
    if (_type == NO) {
        SAuctionOrderOrderList * list = [[SAuctionOrderOrderList alloc] init];
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
            [listView showCarModel:arr andType:@"比价购纪录"];
            [listView.mTable.mj_header endRefreshing];
            [listView.mTable reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else {
        SIntegralOrderOrderList * list = [[SIntegralOrderOrderList alloc] init];
        list.order_status = order_status_Integral;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sIntegralOrderOrderListSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SIntegralOrderOrderList * list = (SIntegralOrderOrderList *)data;
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
            [listView showCarModel:arr andType:@"积分抽奖"];
            [listView.mTable.mj_header endRefreshing];
            [listView.mTable reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    if (_type == NO) {
        self.title = @"比价记录";
    } else {
        self.title = @"积分抽奖";
    }
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
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

@end
