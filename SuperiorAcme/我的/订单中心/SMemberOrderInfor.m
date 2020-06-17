//
//  SMemberOrderInfor.m
//  SuperiorAcme
//
//  Created by GYM on 2018/3/13.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SMemberOrderInfor.h"
#import "SMemberOrderInforCell.h"
#import "SMemberOrderMemberOrderInfo.h"
#import "SMemberOrderDelMemberOrder.h"
#import "SMemberOrderSettlement.h"
#import "SEBPay.h"
#import "SUserBalanceHjsInfo.h"
#import "SUserBalanceDelHjsInfo.h"
#import "SRecharge.h"
#import "SPay.h"

/*
 *线下商铺订单详情模型
 */
#import "SOfflineStoreOrderInforModel.h"
@interface SMemberOrderInfor () <UITableViewDelegate,UITableViewDataSource>
{
    NSArray * arr;
}
@property (weak, nonatomic) IBOutlet UITableView *mTable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mTable_HHH;
@property (weak, nonatomic) IBOutlet UIButton *oneBtn;
@property (weak, nonatomic) IBOutlet UIButton *twoBtn;
@end

@implementation SMemberOrderInfor

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
    //    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"订单详情";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
}
- (void)viewDidAppear:(BOOL)animated {
    
    [self showModel];
}
- (void)showModel {
    if ([_type isEqualToString:@"会员卡"]) {
        SMemberOrderMemberOrderInfo * infor = [[SMemberOrderMemberOrderInfo alloc] init];
        infor.order_id = _order_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [infor sMemberOrderMemberOrderInfoSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            SMemberOrderMemberOrderInfo * infor = (SMemberOrderMemberOrderInfo *)data;
            arr = infor.data;
            [_mTable reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_type isEqualToString:@"充值"]) {
        SUserBalanceHjsInfo * infor = [[SUserBalanceHjsInfo alloc] init];
        infor.order_id = _order_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [infor sUserBalanceHjsInfoSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            SUserBalanceHjsInfo * infor = (SUserBalanceHjsInfo *)data;
            arr = infor.data;
            [_mTable reloadData];
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    if ([_type isEqualToString:@"线下商铺"]) {
        SOfflineStoreOrderInforModel * offlineOrderInfor = [[SOfflineStoreOrderInforModel alloc] init];
        offlineOrderInfor.order_id = _order_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [offlineOrderInfor sOfflineStoreOrderInfoSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([data isKindOfClass:[NSArray class]]) {
                arr = (NSArray *)data;
                [_mTable reloadData];
            }else if ([data isKindOfClass:[NSDictionary class]]){
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    }
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _oneBtn.layer.masksToBounds = YES;
    _oneBtn.layer.cornerRadius = 15;
    _oneBtn.layer.borderWidth = 0.5;
    _oneBtn.layer.borderColor = WordColor_30.CGColor;
    _twoBtn.layer.masksToBounds = YES;
    _twoBtn.layer.cornerRadius = 15;
    _twoBtn.layer.borderWidth = 0.5;
    _twoBtn.layer.borderColor = [UIColor redColor].CGColor;
    
    _mTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_mTable registerNib:[UINib nibWithNibName:@"SMemberOrderInforCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SMemberOrderInforCell"];
    
    if ([_type isEqualToString:@"会员卡"]) {
        if ([_order_status integerValue] == 1) {
            [_oneBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [_twoBtn setTitle:@"立即支付" forState:UIControlStateNormal];
        } else if ([_order_status integerValue] == 2) {
            _oneBtn.hidden = YES;
            [_twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        } else if ([_order_status integerValue] == 5) {
            _oneBtn.hidden = YES;
            [_twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        } else {
            _mTable_HHH.constant = 0;
        }
    }
    if ([_type isEqualToString:@"充值"]) {
        if ([_order_status integerValue] == 0) {
            [_oneBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [_twoBtn setTitle:@"立即支付" forState:UIControlStateNormal];
        } else if ([_order_status integerValue] == 1) {
            _oneBtn.hidden = YES;
            [_twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        } else if ([_order_status integerValue] == 5) {
            _oneBtn.hidden = YES;
            [_twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        } else {
            _mTable_HHH.constant = 0;
        }
    }
    
    if ([_type isEqualToString:@"线下商铺"]) {
        if (_pay_status.integerValue == 1) {//已支付
            //显示删除按钮
            if (_status.integerValue == 0){
                _oneBtn.hidden = _common_status;
                [_oneBtn setTitle:@"评价" forState:0];
            }else{
                _oneBtn.hidden = YES;
                [_twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                if (_status.integerValue == 10086){ //自定义数据  隐藏删除按钮
                    _twoBtn.hidden = YES;
                    _mTable_HHH.constant = 0;
                }
            }
        }else if (_pay_status.integerValue == 0){//未支付
            if (_status.integerValue == 0) {//正常订单
                //显示取消和立即支付按钮
                [_oneBtn setTitle:@"取消订单" forState:UIControlStateNormal];
                [_twoBtn setTitle:@"立即支付" forState:UIControlStateNormal];
            }else if (_status.integerValue == 5){//取消订单
                //显示删除按钮
                _oneBtn.hidden = YES;
                [_twoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
            }else {
                _mTable_HHH.constant = 0;
            }
        }
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SMemberOrderInforCell * cell = [_mTable dequeueReusableCellWithIdentifier:@"SMemberOrderInforCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if ([_type isEqualToString:@"会员卡"]) {
        SMemberOrderMemberOrderInfo * infor = arr[indexPath.row];
        cell.one.text = infor.order_name;
        cell.two.text = infor.order_value;
    }
    if ([_type isEqualToString:@"充值"]) {
        SUserBalanceHjsInfo * infor = arr[indexPath.row];
        cell.one.text = infor.order_name;
        cell.two.text = infor.order_value;
    }
    if ([_type isEqualToString:@"线下商铺"]) {
        SOfflineStoreOrderInforModel * infor = arr[indexPath.row];
        cell.one.text = infor.order_name;
        cell.two.text = infor.order_value;
    }
    
    
    return cell;
}

- (IBAction)oneBtn:(UIButton *)sender {
    
    if ([_type isEqualToString:@"线下商铺"]){
        if ([sender.titleLabel.text isEqualToString:@"评价"]) {
             SEvaUnderLineShopVC * evaSubmit = [[SEvaUnderLineShopVC alloc] init];
             evaSubmit.order_id = _order_id;
            evaSubmit.isPopRootVC = YES;
             [self.navigationController pushViewController:evaSubmit animated:YES];
            return;
        }
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"取消订单?" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击取消");
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击确定");
        
        if ([_type isEqualToString:@"会员卡"]) {
            SMemberOrderDelMemberOrder * order = [[SMemberOrderDelMemberOrder alloc] init];
            order.order_id = _order_id;
            order.order_status = @"5";
            [MBProgressHUD showMessage:nil toView:self.view];
            [order sMemberOrderDelMemberOrderSuccess:^(NSString *code, NSString *message) {
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
        }
        if ([_type isEqualToString:@"充值"]) {
            
            SUserBalanceDelHjsInfo * order = [[SUserBalanceDelHjsInfo alloc] init];
            order.order_id = _order_id;
            order.order_status = @"5";
            [MBProgressHUD showMessage:nil toView:self.view];
            [order sUserBalanceDelHjsInfoSuccess:^(NSString *code, NSString *message) {
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
        }
        
        if ([_type isEqualToString:@"线下商铺"]) {
            SOfflineStoreOrderInforModel *orderInfoModel = [SOfflineStoreOrderInforModel new];
            orderInfoModel.order_id = _order_id;
            orderInfoModel.order_status = @"5";
            [MBProgressHUD showMessage:nil toView:self.view];
            [orderInfoModel sOfflineStoreDelOrderSuccess:^(NSString *code, NSString *message, id data) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                [MBProgressHUD showError:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if ([code isEqualToString:@"1"]){
                       [self.navigationController popViewControllerAnimated:YES];
//                        [self showModel];
//                        sender.hidden = YES;
                    }
                });
            } andFailure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            }];
        }
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}


- (IBAction)twoBtn:(UIButton *)sender {
    if ([_twoBtn.titleLabel.text isEqualToString:@"立即支付"]) {
        if ([_type isEqualToString:@"会员卡"]) {
            SMemberOrderSettlement * show = [[SMemberOrderSettlement alloc] init];
            show.member_coding = _member_coding;
            [show sMemberOrderSettlementSuccess:^(NSString *code, NSString *message, id data) {
                if ([code isEqualToString:@"1"]) {
                    SMemberOrderSettlement * show = (SMemberOrderSettlement *)data;
                    
                    SEBPay * pay = [[SEBPay alloc] init];
                    pay.type = @"2";
                    pay.rank_id = show.data.rank_id;
                    pay.rank_name = show.data.rank_name;
                    pay.money = show.data.pay_money;
                    pay.member_coding = _member_coding;
                    pay.order_id = _order_id;
                    [self.navigationController pushViewController:pay animated:YES];
                } else {
                    [MBProgressHUD showError:message toView:self.view];
                }
            } andFailure:^(NSError *error) {
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            }];
        }
        if ([_type isEqualToString:@"充值"]) {
            SRecharge * rech = [[SRecharge alloc] init];
            rech.order_id = _order_id;
            rech.money = _member_coding;
            [self.navigationController pushViewController:rech animated:YES];
        }
        
        if ([_type isEqualToString:@"线下商铺"]){
            SPay * pay = [[SPay alloc] init];
            pay.model_type = @"线下商铺";
            pay.isPopRootVC = NO;
            pay.order_id = _order_id;
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
                order.order_id = _order_id;
                order.order_status = @"9";
                [MBProgressHUD showMessage:nil toView:self.view];
                [order sMemberOrderDelMemberOrderSuccess:^(NSString *code, NSString *message) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    if ([code isEqualToString:@"1"]) {
                        [MBProgressHUD showSuccess:message toView:self.view];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self.navigationController popViewControllerAnimated:YES];
                        });
                    } else {
                        [MBProgressHUD showError:message toView:self.view];
                    }
                } andFailure:^(NSError *error) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                }];
            }
            if ([_type isEqualToString:@"充值"]) {
                
                SUserBalanceDelHjsInfo * order = [[SUserBalanceDelHjsInfo alloc] init];
                order.order_id = _order_id;
                order.order_status = @"9";
                [MBProgressHUD showMessage:nil toView:self.view];
                [order sUserBalanceDelHjsInfoSuccess:^(NSString *code, NSString *message) {
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
            }
            
            if ([_type isEqualToString:@"线下商铺"]) {
                SOfflineStoreOrderInforModel *orderInfoModel = [SOfflineStoreOrderInforModel new];
                orderInfoModel.order_id = _order_id;
                orderInfoModel.order_status = @"9";
                [MBProgressHUD showMessage:nil toView:self.view];
                [orderInfoModel sOfflineStoreDelOrderSuccess:^(NSString *code, NSString *message, id data) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    
                    [MBProgressHUD showError:message toView:self.view];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        if ([code isEqualToString:@"1"]){
                            [self.navigationController popViewControllerAnimated:YES];
                        }
                    });
                } andFailure:^(NSError *error) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                }];
            }
            
            
            
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
@end
