//
//  SHouseConfirm.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/30.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SHouseConfirm.h"
#import "SPay.h"
#import "SHouseOrderOrderInfo.h"
#import "SHouse_Map.h"
#import "SEvaCar.h"
#import "SHouseOrderCancelOrder.h"
#import "SHouseOrderDeleteOrder.h"

@interface SHouseConfirm () <UITextFieldDelegate>
{
    NSString * shop_name;//": "",//店铺名称
    NSString * lng;//": "0.00",//店铺经度
    NSString * lat;//": "0.00",//店铺纬度
    NSString * link_phone;
}
@property (strong, nonatomic) IBOutlet UIImageView *house_img;
@property (strong, nonatomic) IBOutlet UILabel *house_name;
@property (strong, nonatomic) IBOutlet UITextField *numTF;
@property (strong, nonatomic) IBOutlet UILabel *pre_moneyR;
@property (strong, nonatomic) IBOutlet UILabel *pre_money;
@property (strong, nonatomic) IBOutlet UILabel *all_price;
@property (strong, nonatomic) IBOutlet UILabel *true_pre_money;
@property (strong, nonatomic) IBOutlet UILabel *developer;
@property (strong, nonatomic) IBOutlet UILabel *submitPrice;
@property (strong, nonatomic) IBOutlet UIScrollView *mScroll;

@property (strong, nonatomic) IBOutlet UILabel *showNum;

@property (strong, nonatomic) IBOutlet UIView *show_first_twoView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *show_first_twoView_HHH;
@property (strong, nonatomic) IBOutlet UILabel *discount_price;
@property (strong, nonatomic) IBOutlet UIImageView *discount_image;
@property (strong, nonatomic) IBOutlet UIView *show_first_threeView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *show_firt_threeView_HHH;
@property (strong, nonatomic) IBOutlet UILabel *integral;
@property (strong, nonatomic) IBOutlet UIView *show_first_fourView;
@property (strong, nonatomic) IBOutlet UILabel *order_price;

@property (strong, nonatomic) IBOutlet UIView *show_secend_oneView;
@property (strong, nonatomic) IBOutlet UILabel *shop_name;
@property (strong, nonatomic) IBOutlet UIView *show_secend_twoView;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UIView *show_secend_threeView;
@property (strong, nonatomic) IBOutlet UILabel *contact_name;
@property (strong, nonatomic) IBOutlet UIView *show_second_fourView;
@property (strong, nonatomic) IBOutlet UILabel *contact_mobile;

@property (strong, nonatomic) IBOutlet UIView *show_third_oneView;
@property (strong, nonatomic) IBOutlet UILabel *order_sn;
@property (strong, nonatomic) IBOutlet UIView *show_third_twoView;
@property (strong, nonatomic) IBOutlet UILabel *create_time;
@property (strong, nonatomic) IBOutlet UIView *show_third_threeView;
@property (strong, nonatomic) IBOutlet UILabel *pay_type;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *scrollView_HHH;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *scrollView_downHHH;
@property (strong, nonatomic) IBOutlet UIView *downView;
@property (strong, nonatomic) IBOutlet UIButton *downOneBtn;
@property (strong, nonatomic) IBOutlet UIButton *downTwoBtn;
@property (strong, nonatomic) IBOutlet UIButton *mapBtn;
@property (strong, nonatomic) IBOutlet UIButton *calBtn;
@end

@implementation SHouseConfirm


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"提交订单";
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = YES;
    adjustsScrollViewInsets_NO(_mScroll, self);
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _pre_moneyR.layer.masksToBounds = YES;
    _pre_moneyR.layer.cornerRadius = 3;
    _downOneBtn.layer.masksToBounds = YES;
    _downOneBtn.layer.cornerRadius = 15;
    _downOneBtn.layer.borderWidth = 1.0;
    _downOneBtn.layer.borderColor = MyLine.CGColor;
    
    _downTwoBtn.layer.masksToBounds = YES;
    _downTwoBtn.layer.cornerRadius = 15;
    _downTwoBtn.layer.borderWidth = 1.0;
    _downTwoBtn.layer.borderColor = [UIColor redColor].CGColor;
    
    [_mapBtn addTarget:self action:@selector(mapBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_calBtn addTarget:self action:@selector(calBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self showModel];
}
- (void)showModel {
    if (_infor_isno == NO) {
        self.title = @"提交订单";
        [_house_img sd_setImageWithURL:[NSURL URLWithString:_model_house_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
        _house_name.text = _model_house_name;
        _pre_money.text = [NSString stringWithFormat:@"￥%@",_model_pre_money];
        _all_price.text = [NSString stringWithFormat:@"房全款：￥%@",_model_all_price];
        _true_pre_money.text = [NSString stringWithFormat:@"可    抵：￥%@房款",_model_true_pre_money];
        _developer.text = [NSString stringWithFormat:@"%@ %@元/平",_model_developer,_model_one_price];
        _submitPrice.text = [NSString stringWithFormat:@"￥%.2f",[_model_pre_money floatValue] * [_numTF.text integerValue]];
        _numTF.delegate = self;
        _show_first_twoView.hidden = YES;
        _show_first_threeView.hidden = YES;
        _show_first_fourView.hidden = YES;
        _show_secend_oneView.hidden = YES;
        _show_secend_twoView.hidden = YES;
        _show_secend_threeView.hidden = YES;
        _show_second_fourView.hidden = YES;
        _show_third_oneView.hidden = YES;
        _show_third_twoView.hidden = YES;
        _show_third_threeView.hidden = YES;
        _downView.hidden = YES;
        _scrollView_HHH.constant = 500;
        
        _showNum.hidden = YES;
    } else {
        
        SHouseOrderOrderInfo * infor = [[SHouseOrderOrderInfo alloc] init];
        infor.order_id = _order_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [infor sHouseOrderOrderInfoSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                
                SHouseOrderOrderInfo * infor = (SHouseOrderOrderInfo *)data;
                shop_name = infor.data.house_name;
                lng = infor.data.lng;
                lat = infor.data.lat;
                if ([infor.data.status isEqualToString:@"0"]) {
                    self.title = @"待付款";
                    _downOneBtn.hidden = NO;
                    _downTwoBtn.hidden = NO;
                    [_downOneBtn setTitle:@"取消订单" forState:UIControlStateNormal];
                    [_downTwoBtn setTitle:@"付款" forState:UIControlStateNormal];
                } else if ([infor.data.status isEqualToString:@"1"]) {
                    self.title = @"办理手续中";
                    _downOneBtn.hidden = YES;
                    _downTwoBtn.hidden = YES;
                    _scrollView_downHHH.constant = 0;
                } else if ([infor.data.status isEqualToString:@"2"]) {
                    self.title = @"待评价";
                    _downOneBtn.hidden = YES;
                    _downTwoBtn.hidden = NO;
                    [_downTwoBtn setTitle:@"评价" forState:UIControlStateNormal];
                } else if ([infor.data.status isEqualToString:@"4"]) {
                    self.title = @"已完成";
                    _downOneBtn.hidden = YES;
                    _downTwoBtn.hidden = NO;
                    [_downTwoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                } else if ([infor.data.status isEqualToString:@"5"]) {
                    self.title = @"已取消";
                    _downOneBtn.hidden = YES;
                    _downTwoBtn.hidden = NO;
                    [_downTwoBtn setTitle:@"删除订单" forState:UIControlStateNormal];
                }
                
                
                [_house_img sd_setImageWithURL:[NSURL URLWithString:infor.data.house_style_img] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
                _house_name.text = infor.data.style_name;
                _pre_money.text = [NSString stringWithFormat:@"￥%@",infor.data.pre_money];
                _all_price.text = [NSString stringWithFormat:@"房全款：￥%@",infor.data.all_price];
                _true_pre_money.text = [NSString stringWithFormat:@"可    抵：￥%@房款",infor.data.true_pre_money];
                _showNum.text = [NSString stringWithFormat:@"x%@",infor.data.num];
                _developer.text = [NSString stringWithFormat:@"%@ %@元/平",infor.data.house_name,infor.data.one_price];
                
                if ([infor.data.discount floatValue] >= 0.01) {
                    _discount_image.hidden = NO;
                    _discount_price.text = [NSString stringWithFormat:@"￥ -%@",infor.data.discount];
                    _discount_image.image = [UIImage imageNamed:@"代金券红"];
                    _show_first_twoView.hidden = NO;
                    _show_first_twoView_HHH.constant = 50;
                } else {
                    _discount_image.hidden = YES;
                    _show_first_twoView.hidden = YES;
                    _show_first_twoView_HHH.constant = 0;
                }
                if ([infor.data.yellow_discount floatValue] >= 0.01) {
                    _discount_image.hidden = NO;
                    _discount_price.text = [NSString stringWithFormat:@"￥ -%@",infor.data.yellow_discount];
                    _discount_image.image = [UIImage imageNamed:@"代金券黄"];
                    _show_first_twoView.hidden = NO;
                    _show_first_twoView_HHH.constant = 50;
                } else {
                    _discount_image.hidden = YES;
                    _show_first_twoView.hidden = YES;
                    _show_first_twoView_HHH.constant = 0;
                }
                if ([infor.data.blue_discount floatValue] >= 0.01) {
                    _discount_image.hidden = NO;
                    _discount_price.text = [NSString stringWithFormat:@"￥ -%@",infor.data.blue_discount];
                    _discount_image.image = [UIImage imageNamed:@"代金券蓝"];
                    _show_first_twoView.hidden = NO;
                    _show_first_twoView_HHH.constant = 50;
                } else {
                    _discount_image.hidden = YES;
                    _show_first_twoView.hidden = YES;
                    _show_first_twoView_HHH.constant = 0;
                }
                
                _integral.text = [NSString stringWithFormat:@"-%@",infor.data.integral];
                if ([infor.data.integral floatValue] >= 0.01) {
                    _show_first_threeView.hidden = NO;
                    _show_firt_threeView_HHH.constant = 50;
                } else {
                    _show_first_threeView.hidden = YES;
                    _show_firt_threeView_HHH.constant = 0;
                }
                _order_price.text = [NSString stringWithFormat:@"￥%@",infor.data.order_price];
                _shop_name.text = infor.data.style_name;
                _address.text = infor.data.sell_address;
                _contact_name.text = infor.data.link_man;
                _contact_mobile.text = infor.data.link_phone;
                link_phone = infor.data.link_phone;
                _order_sn.text = infor.data.order_sn;
                _create_time.text = infor.data.create_time;
                if ([infor.data.pay_type isEqualToString:@"0"]) {
                    _pay_type.text = @"待支付";
                } else if ([infor.data.pay_type isEqualToString:@"1"]) {
                    _pay_type.text = @"支付宝";
                } else if ([infor.data.pay_type isEqualToString:@"2"]) {
                    _pay_type.text = @"微信";
                } else if ([infor.data.pay_type isEqualToString:@"3"]) {
                    _pay_type.text = @"余额";
                } else if ([infor.data.pay_type isEqualToString:@"4"]) {
                    _pay_type.text = @"积分";
                }
            } else {
                [MBProgressHUD showError:message toView:self.view];
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
    if (self.SHouseConfirm_Back) {
        self.SHouseConfirm_Back();
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)leftBtn:(UIButton *)sender {
    if ([_numTF.text integerValue] > 1) {
        _numTF.text = [NSString stringWithFormat:@"%ld",[_numTF.text integerValue] - 1];
    }
    _submitPrice.text = [NSString stringWithFormat:@"￥%.2f",[_model_pre_money floatValue] * [_numTF.text integerValue]];
}

- (IBAction)rightBtn:(UIButton *)sender {
    _numTF.text = [NSString stringWithFormat:@"%ld",[_numTF.text integerValue] + 1];
    _submitPrice.text = [NSString stringWithFormat:@"￥%.2f",[_model_pre_money floatValue] * [_numTF.text integerValue]];
    
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    _submitPrice.text = [NSString stringWithFormat:@"￥%.2f",[_model_pre_money floatValue] * [_numTF.text integerValue]];
    return YES;
}
- (IBAction)submitBtn:(UIButton *)sender {
    SPay * payVC = [[SPay alloc] init];
    payVC.model_type = @"房产购";
    payVC.car_id = _model_house_id;
    payVC.num = _numTF.text;
    [self.navigationController pushViewController:payVC animated:YES];
}
- (void)mapBtnClick {
    
    SHouse_Map * map = [[SHouse_Map alloc] init];
    map.model_lng = lng;
    map.model_lat = lat;
    map.model_houseName = shop_name;
    [self.navigationController pushViewController:map animated:YES];
}
- (IBAction)downOneBtn:(UIButton *)sender {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"取消订单?" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击取消");
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击确定");
        SHouseOrderCancelOrder * cancel_order = [[SHouseOrderCancelOrder alloc] init];
        cancel_order.order_id = _order_id;
        [MBProgressHUD showMessage:nil toView:self.view];
        [cancel_order sHouseOrderCancelOrderSuccess:^(NSString *code, NSString *message) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                [MBProgressHUD showSuccess:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (self.SHouseConfirm_Back) {
                        self.SHouseConfirm_Back();
                    }
                    [self.navigationController popViewControllerAnimated:YES];
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
- (IBAction)downTwoBtn:(UIButton *)sender {
    if ([sender.titleLabel.text isEqualToString:@"付款"]) {
        SPay * pay = [[SPay alloc] init];
        pay.model_type = @"房产购";
        pay.order_id = _order_id;
        [self.navigationController pushViewController:pay animated:YES];
        pay.SPay_Back = ^{
            [self showModel];
        };
    } else if ([sender.titleLabel.text isEqualToString:@"评价"]) {
        //房产购评价
        SEvaCar * carEva = [[SEvaCar alloc] init];
        carEva.type = @"房产购";
        carEva.order_id = _order_id;
        [self.navigationController pushViewController:carEva animated:YES];
        carEva.SEvaCar_Back = ^{
            [self showModel];
        };
    } else if ([sender.titleLabel.text isEqualToString:@"删除订单"]) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除订单?" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击取消");
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"点击确定");
            SHouseOrderDeleteOrder * cancel_order = [[SHouseOrderDeleteOrder alloc] init];
            cancel_order.order_id = _order_id;
            [MBProgressHUD showMessage:nil toView:self.view];
            [cancel_order sHouseOrderDeleteOrderSuccess:^(NSString *code, NSString *message) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([code isEqualToString:@"1"]) {
                    [MBProgressHUD showSuccess:message toView:self.view];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        if (self.SHouseConfirm_Back) {
                            self.SHouseConfirm_Back();
                        }
                        [self.navigationController popViewControllerAnimated:YES];
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
}
- (void)calBtnClick {
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"tel://%@",link_phone]]] options:@{}completionHandler:^(BOOL success) {
    }];
}
@end
