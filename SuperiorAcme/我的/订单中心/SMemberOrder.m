//
//  SMemberOrder.m
//  SuperiorAcme
//
//  Created by GYM on 2018/3/13.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SMemberOrder.h"
#import "SNPageView.h"
#import "SMemberOrderView.h"
#import "SMemberOrderInfor.h"
#import "SMemberOrderMemberOrderList.h"
#import "SMemberOrderDelMemberOrder.h"
#import "SEBPay.h"
#import "SMemberOrderSettlement.h"
#import "SUserBalanceUserBalanceHjs.h"
#import "SUserBalanceDelHjsInfo.h"
#import "SRecharge.h"
#import "SPay.h"

#import "SOfflineStoreOrderListModel.h"
#import "SOfflineStoreOrderInforModel.h"

@interface SMemberOrder ()
{
    BOOL firstBegin;//是否刷新
    NSMutableArray * arr;//列表
    NSInteger  page;
    SMemberOrderView * listView;
    NSString * pay_status;//默认不传 0未支付 1已支付
}
@end

@implementation SMemberOrder

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
}
- (void)viewDidAppear:(BOOL)animated {
    
    if (firstBegin == NO) {
        firstBegin = YES;//再次返回要刷新数据了
    } else {
        [self showModel];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = _type;//会员卡 充值
    if([_type isEqualToString:@"线下店铺"]){
        _type = @"线下商铺";
    }
    
    [self createNav];

    SNPageView * pageView = [[SNPageView alloc] initWithFrame:CGRectMake(0, 64.5, ScreenW, ScreenH - 64.5) p_style:PageViewStyleLine];
    pageView.subViews = @[[SMemberOrderView class],[SMemberOrderView class],[SMemberOrderView class]];
    pageView.titles = @[@"全部",@"未支付",@"已支付"];
    pageView.titleWidth = [UIScreen mainScreen].bounds.size.width/3;
    pageView.titleSelectedFont = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    pageView.sliderColor = WordColor;
    pageView.defaultSelectedIndex = 0;
    pageView.topTitleViewColor = [UIColor whiteColor];
    pageView.goundNormalColor = [UIColor whiteColor];
    __block SMemberOrder * gSelf = self;
    __weak typeof(self) WeakSelf = self;
//    __weak typeof(pageView) weakPageView = pageView;
    [pageView showInView:self.view action:^(id subView, UIButton *btn, NSInteger index) {
        
        NSLog(@"%@",[subView class]);
        if (index == 0) {
            listView = subView;
            pay_status = @"";
        } else if (index == 1) {
            listView = subView;
            pay_status = @"0";
        } else if (index == 2) {
            listView = subView;
            pay_status = @"1";
        }
        
        if(SWNOTEmptyStr(_pay_status)){
            pay_status = _pay_status;
        }
        
        page = 1;
        [self initRefresh];
        [self showModel];
        
        //详情
        listView.SMemberOrderViewInfor = ^(NSString *order_id, NSString * order_status,  NSString * member_coding) {
            SMemberOrderInfor * infor = [[SMemberOrderInfor alloc] init];
            infor.order_id = order_id;
            infor.order_status = order_status;
            infor.member_coding = member_coding;
            infor.type = WeakSelf.type;
            [gSelf.navigationController pushViewController:infor animated:YES];
        };
        /*
         *线下商铺订单详情
         */
        listView.SOfflineStoreOrderInfor = ^(NSString *order_id, NSString *merchant_id, NSString *pay_status, NSString *status, BOOL common_status) {
            SMemberOrderInfor * infor = [[SMemberOrderInfor alloc] init];
            infor.order_id = order_id;
            infor.pay_status = pay_status;
            infor.merchant_id = merchant_id;
            infor.common_status = common_status;
            infor.status = status;
            infor.type = WeakSelf.type;
            [gSelf.navigationController pushViewController:infor animated:YES];
        };
        
        
        //取消
        listView.SMemberOrderViewOneBtn = ^(NSString *order_id, NSString *order_status) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"取消订单?" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"点击取消");
            }]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"点击确定");
                
                if ([WeakSelf.type isEqualToString:@"会员卡"]) {
                    SMemberOrderDelMemberOrder * order = [[SMemberOrderDelMemberOrder alloc] init];
                    order.order_id = order_id;
                    order.order_status = @"5";
                    [MBProgressHUD showMessage:nil toView:gSelf.view];
                    [order sMemberOrderDelMemberOrderSuccess:^(NSString *code, NSString *message) {
                        [MBProgressHUD hideHUDForView:gSelf.view animated:YES];
                        if ([code isEqualToString:@"1"]) {
                            [MBProgressHUD showSuccess:message toView:gSelf.view];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                page = 1;
                                [gSelf showModel];
                            });
                        } else {
                            [MBProgressHUD showError:message toView:gSelf.view];
                        }
                    } andFailure:^(NSError *error) {
                        [MBProgressHUD hideHUDForView:gSelf.view animated:YES];
                        [MBProgressHUD showError:[error localizedDescription] toView:gSelf.view];
                    }];
                }
                if ([WeakSelf.type isEqualToString:@"充值"]) {
                    
                    SUserBalanceDelHjsInfo * order = [[SUserBalanceDelHjsInfo alloc] init];
                    order.order_id = order_id;
                    order.order_status = @"5";
                    [MBProgressHUD showMessage:nil toView:gSelf.view];
                    [order sUserBalanceDelHjsInfoSuccess:^(NSString *code, NSString *message) {
                        [MBProgressHUD hideHUDForView:gSelf.view animated:YES];
                        if ([code isEqualToString:@"1"]) {
                            [MBProgressHUD showSuccess:message toView:gSelf.view];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                page = 1;
                                [gSelf showModel];
                            });
                        } else {
                            [MBProgressHUD showError:message toView:gSelf.view];
                        }
                    } andFailure:^(NSError *error) {
                        [MBProgressHUD hideHUDForView:gSelf.view animated:YES];
                        [MBProgressHUD showError:[error localizedDescription] toView:gSelf.view];
                    }];
                }
                
                if ([WeakSelf.type isEqualToString:@"线下商铺"]) {
                    SOfflineStoreOrderInforModel *orderInfoModel = [SOfflineStoreOrderInforModel new];
                    orderInfoModel.order_id = order_id;
                    orderInfoModel.order_status = @"5";
                    [MBProgressHUD showMessage:nil toView:WeakSelf.view];
                    [orderInfoModel sOfflineStoreDelOrderSuccess:^(NSString *code, NSString *message, id data) {
                        [MBProgressHUD hideHUDForView:WeakSelf.view animated:YES];
                        
                        [MBProgressHUD showError:message toView:WeakSelf.view];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            if ([code isEqualToString:@"1"]){
                                [WeakSelf showModel];
                            }
                        });
                    } andFailure:^(NSError *error) {
                        [MBProgressHUD hideHUDForView:self.view animated:YES];
                        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                    }];
                }
                
                
            }]];
            [gSelf presentViewController:alertController animated:YES completion:nil];
        };
        //删除
        listView.SMemberOrderViewTwoBtn = ^(NSString *order_id, NSString *order_status, UIButton * btn, NSString * member_coding) {
            if ([btn.titleLabel.text isEqualToString:@"立即支付"]) {
                if ([_type isEqualToString:@"会员卡"]) {
                    SMemberOrderSettlement * show = [[SMemberOrderSettlement alloc] init];
                    show.member_coding = member_coding;
                    [show sMemberOrderSettlementSuccess:^(NSString *code, NSString *message, id data) {
                        if ([code isEqualToString:@"1"]) {
                            SMemberOrderSettlement * show = (SMemberOrderSettlement *)data;
                            
                            SEBPay * pay = [[SEBPay alloc] init];
                            pay.type = @"2";
                            pay.rank_id = show.data.rank_id;
                            pay.rank_name = show.data.rank_name;
                            pay.money = show.data.pay_money;
                            pay.member_coding = member_coding;
                            pay.order_id = order_id;
                            [gSelf.navigationController pushViewController:pay animated:YES];
                            
                        } else {
                            [MBProgressHUD showError:message toView:gSelf.view];
                        }
                    } andFailure:^(NSError *error) {
                        [MBProgressHUD showError:[error localizedDescription] toView:gSelf.view];
                    }];
                }
                if ([_type isEqualToString:@"充值"]) {
                    SRecharge * rech = [[SRecharge alloc] init];
                    rech.order_id = order_id;
                    rech.money = member_coding;
                    [self.navigationController pushViewController:rech animated:YES];
                }
                
                if ([_type isEqualToString:@"线下商铺"]){
                    SPay * pay = [[SPay alloc] init];
                    pay.model_type = @"线下商铺";
                    pay.isPopRootVC = NO;
                    pay.order_id = order_id;
//                    pay.pay_money = @"0.01";
                    [self.navigationController pushViewController:pay
                                                         animated:YES];
                }
                
            } else {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除订单?" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    NSLog(@"点击取消");
                }]];
                [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSLog(@"点击确定");
                    if ([_type isEqualToString:@"会员卡"]) {
                        SMemberOrderDelMemberOrder * order = [[SMemberOrderDelMemberOrder alloc] init];
                        order.order_id = order_id;
                        order.order_status = @"9";
                        [MBProgressHUD showMessage:nil toView:gSelf.view];
                        [order sMemberOrderDelMemberOrderSuccess:^(NSString *code, NSString *message) {
                            [MBProgressHUD hideHUDForView:gSelf.view animated:YES];
                            if ([code isEqualToString:@"1"]) {
                                [MBProgressHUD showSuccess:message toView:gSelf.view];
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    page = 1;
                                    [gSelf showModel];
                                });
                            } else {
                                [MBProgressHUD showError:message toView:gSelf.view];
                            }
                        } andFailure:^(NSError *error) {
                            [MBProgressHUD hideHUDForView:gSelf.view animated:YES];
                            [MBProgressHUD showError:[error localizedDescription] toView:gSelf.view];
                        }];
                    }
                    if ([_type isEqualToString:@"充值"]) {
                        
                        SUserBalanceDelHjsInfo * order = [[SUserBalanceDelHjsInfo alloc] init];
                        order.order_id = order_id;
                        order.order_status = @"9";
                        [MBProgressHUD showMessage:nil toView:gSelf.view];
                        [order sUserBalanceDelHjsInfoSuccess:^(NSString *code, NSString *message) {
                            [MBProgressHUD hideHUDForView:gSelf.view animated:YES];
                            if ([code isEqualToString:@"1"]) {
                                [MBProgressHUD showSuccess:message toView:gSelf.view];
                                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                    page = 1;
                                    [gSelf showModel];
                                });
                            } else {
                                [MBProgressHUD showError:message toView:gSelf.view];
                            }
                        } andFailure:^(NSError *error) {
                            [MBProgressHUD hideHUDForView:gSelf.view animated:YES];
                            [MBProgressHUD showError:[error localizedDescription] toView:gSelf.view];
                        }];
                    }
                    
                    if ([_type isEqualToString:@"线下商铺"]) {
                        SOfflineStoreOrderInforModel *orderInfoModel = [SOfflineStoreOrderInforModel new];
                        orderInfoModel.order_id = order_id;
                        orderInfoModel.order_status = @"9";
                        [MBProgressHUD showMessage:nil toView:self.view];
                        [orderInfoModel sOfflineStoreDelOrderSuccess:^(NSString *code, NSString *message, id data) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            
                            [MBProgressHUD showError:message toView:self.view];
                            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                if ([code isEqualToString:@"1"]){
                                    [self showModel];
                                }
                            });
                        } andFailure:^(NSError *error) {
                            [MBProgressHUD hideHUDForView:self.view animated:YES];
                            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                        }];
                    }
                    
                }]];
                [gSelf presentViewController:alertController animated:YES completion:nil];
            }
        };
#pragma mark - 评价
        
        listView.sMemberOrderViewOneBtnCommentBlock = ^(NSString *order_id, UIButton *btn) {
            SEvaUnderLineShopVC * evaSubmit = [[SEvaUnderLineShopVC alloc] init];
            evaSubmit.order_id = order_id;
            [gSelf.navigationController pushViewController:evaSubmit animated:YES];
        };
        
        
    }];
}
- (void)initRefresh
{
    __block SMemberOrder * blockSelf = self;
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
    
    if ([_type isEqualToString:@"会员卡"]) {
        SMemberOrderMemberOrderList * list = [[SMemberOrderMemberOrderList alloc] init];
        list.pay_status = pay_status;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sMemberOrderMemberOrderListSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SMemberOrderMemberOrderList * list = (SMemberOrderMemberOrderList *)data;
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
            [listView showMolde:arr andType:@"会员卡"];
            [listView.mTable.mj_header endRefreshing];
            [listView.mTable reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_type isEqualToString:@"充值"]) {
        SUserBalanceUserBalanceHjs * list = [[SUserBalanceUserBalanceHjs alloc] init];
        list.pay_status = pay_status;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sUserBalanceUserBalanceHjsSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            SUserBalanceUserBalanceHjs * list = (SUserBalanceUserBalanceHjs *)data;
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
            [listView showMolde:arr andType:@"充值"];
            [listView.mTable.mj_header endRefreshing];
            [listView.mTable reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    /*
     *获取线下商铺的订单列表信息
     */
    if ([_type isEqualToString:@"线下商铺"]) {
        SOfflineStoreOrderListModel * list = [[SOfflineStoreOrderListModel alloc] init];
        list.pay_status = pay_status;
        list.p = [@(page) stringValue];
        [MBProgressHUD showMessage:nil toView:self.view];
        [list sOfflineStoreOrderListSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([data isKindOfClass:[NSArray class]]) {
                NSArray * dataTempArr = nil;
                dataTempArr = (NSArray *)data;
                if (page == 1) {
                    arr = [dataTempArr mutableCopy];
                    [listView.mTable.mj_footer resetNoMoreData];
                } else {
                    if (dataTempArr.count) {
                        [arr addObjectsFromArray:dataTempArr];
                        [listView.mTable.mj_footer endRefreshing];
                    } else {
                        [listView.mTable.mj_footer endRefreshingWithNoMoreData];
                    }
                }
                [listView showMolde:arr andType:@"线下商铺"];
                [listView.mTable.mj_header endRefreshing];
                [listView.mTable reloadData];
            }else if ([data isKindOfClass:[NSDictionary class]]){
            }
            
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
}
- (void)lefthBtnClick {
    if (_coming == YES) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
