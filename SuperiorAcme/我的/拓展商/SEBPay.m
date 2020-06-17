//
//  SEBPay.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/16.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SEBPay.h"
#import "SMemberOrderSettlement.h"//无忧会员支付
#import "SPayChoice.h"
#import "SMemberOrderSetOrder.h"//余额支付
#import "SNPayManager.h"
#import "SMemberAliPayFindPayResult.h"
#import "SMessageInfor.h"
#import "SMemberOrderTicket.h"
#import "SPay_Pass.h"//支付密码验证
#import "SModifyLoginPassword.h"//设置密码
#import "SMemberOrder.h"//会员卡订单
#import "SUserSetting.h"

@interface SEBPay () <UITextFieldDelegate>
{
    NSString * model_discount;//": "1",//是否可以使用红券 0不可使用  1可以使用
    NSString * model_yellow_discount;//": "1",//是否可以使用黄券 0不可使用  1可以使用
    NSString * model_blue_discount;//": "1",//是否可以使用券 0不可使用  1可以使用
    NSString * red_desc;//": ""//红券说明
    NSString * yellow_desc;//": ""//黄券说明
    NSString * blue_desc;//": ""//蓝券说明
    NSString * model_discount_price;
    NSString * model_yellow_discount_price;
    NSString * model_blue_discount_price;
    
    NSString * payType;//1:余额 2:支付宝 3:微信 4:积分
    NSString * discount_type;//使用代金券：0不使用代金券 1使用红券 2使用黄券 3使用蓝券
    NSString * order_id;
    
    NSString * integral_price;//":"//积分支付结算金额"
    
    BOOL payPass_isno;//判断是否支付密码验证

}
//余额
@property (weak, nonatomic) IBOutlet UIButton *oneBtn;
@property (weak, nonatomic) IBOutlet UIImageView *oneBtn_blue;
@property (weak, nonatomic) IBOutlet UIImageView *oneBtn_yellow;
@property (weak, nonatomic) IBOutlet UIImageView *oneBtn_red;
//支付宝
@property (weak, nonatomic) IBOutlet UIButton *twoBtn;
@property (weak, nonatomic) IBOutlet UIImageView *twoBtn_blue;
@property (weak, nonatomic) IBOutlet UIImageView *twoBtn_yellow;
@property (weak, nonatomic) IBOutlet UIImageView *twoBtn_red;
//微信
@property (weak, nonatomic) IBOutlet UIView *weixinView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *weixinView_HHH;
@property (weak, nonatomic) IBOutlet UIButton *threeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *threeBtn_blue;
@property (weak, nonatomic) IBOutlet UIImageView *threeBtn_yellow;
@property (weak, nonatomic) IBOutlet UIImageView *threeBtn_red;
//积分支付
@property (weak, nonatomic) IBOutlet UIButton *fourBtn;
//协议
@property (weak, nonatomic) IBOutlet UILabel *agreement;
//支付
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

//无忧会员卡支付
@property (weak, nonatomic) IBOutlet UIView *top_two;
@property (weak, nonatomic) IBOutlet UIView *top_three;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *type_TopHHH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scroll_HHH;
@property (weak, nonatomic) IBOutlet UILabel *thisTime;

@property (weak, nonatomic) IBOutlet UILabel *thisRank_name;
@property (weak, nonatomic) IBOutlet UILabel *thisMoney;
@property (weak, nonatomic) IBOutlet UILabel *thisBalance;
@property (weak, nonatomic) IBOutlet UILabel *thisIntegral;
@property (weak, nonatomic) IBOutlet UIView *fourTypeView;
@property (weak, nonatomic) IBOutlet UIButton *num_leftBtn;
@property (weak, nonatomic) IBOutlet UITextField *numTF;
@property (weak, nonatomic) IBOutlet UIButton *num_rightBtn;
@end

@implementation SEBPay

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    //默认余额
//    [_oneBtn setImage:[UIImage imageNamed:@"R选中"] forState:UIControlStateNormal];
    _oneBtn_blue.hidden = YES;
    _oneBtn_yellow.hidden = YES;
    _oneBtn_red.hidden = YES;
    
    _twoBtn_blue.hidden = YES;
    _twoBtn_yellow.hidden = YES;
    _twoBtn_red.hidden = YES;
    
    _threeBtn_blue.hidden = YES;
    _threeBtn_yellow.hidden = YES;
    _threeBtn_red.hidden = YES;
    
    _numTF.delegate = self;
    discount_type = @"0";
    
    if (![WXApi isWXAppInstalled]) {
        _weixinView.hidden = YES;
        _weixinView_HHH.constant = 0;
    }
    
    NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"购买即视为同意《无界优品会员协议》"];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(7, 10)];
    _agreement.attributedText = AttributedStr;
    
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 3;
    
    _thisTime.layer.masksToBounds = YES;
    _thisTime.layer.cornerRadius = 3;
    if ([_type isEqualToString:@"1"]) {
        self.title = @"支付成为拓展商";
        _type_TopHHH.constant = 0;
        _scroll_HHH.constant = 450;
        _top_two.hidden = YES;
        _top_three.hidden = YES;
    }
    if ([_type isEqualToString:@"2"]) {
        self.title = _rank_name;
        _thisRank_name.text = _rank_name;
        _type_TopHHH.constant = 50;
        _scroll_HHH.constant = 500;
        _top_two.hidden = NO;
        _top_three.hidden = YES;
        _thisMoney.text = [NSString stringWithFormat:@"￥%@",_money];
        
        [self showModel];
        [self showModel_sub];
    }
    if ([_type isEqualToString:@"3"]) {
        self.title = @"提交订单";
        _type_TopHHH.constant = 160;
        _scroll_HHH.constant = 610;
        _top_two.hidden = YES;
        _top_three.hidden = NO;
    }
}
- (void)showModel {
    SMemberOrderSettlement * show = [[SMemberOrderSettlement alloc] init];
    show.member_coding = _member_coding;
    [MBProgressHUD showMessage:nil toView:self.view];
    [show sMemberOrderSettlementSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            SMemberOrderSettlement * show = (SMemberOrderSettlement *)data;
            _thisBalance.text = [NSString stringWithFormat:@"（余额￥%@）",show.data.balance];
            _thisIntegral.text = [NSString stringWithFormat:@"（剩余积分%@）",show.data.integral];
            integral_price = show.data.integral_price;//积分支付的单价积分
            if ([show.data.is_integral integerValue] == 0) {
                _fourTypeView.hidden = YES;
            }
            
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
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
#pragma mark - 余额支付
- (IBAction)oneBtn:(UIButton *)sender {
    payType = @"1";
    _thisMoney.text = [NSString stringWithFormat:@"￥%.2f",[_numTF.text integerValue] * [_money floatValue]];
    [_oneBtn setImage:[UIImage imageNamed:@"R选中"] forState:UIControlStateNormal];
    [_twoBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    [_threeBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    [_fourBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    
    _oneBtn_blue.hidden = YES;
    _oneBtn_yellow.hidden = YES;
    _oneBtn_red.hidden = YES;
    
    _twoBtn_blue.hidden = YES;
    _twoBtn_yellow.hidden = YES;
    _twoBtn_red.hidden = YES;
    
    _threeBtn_blue.hidden = YES;
    _threeBtn_yellow.hidden = YES;
    _threeBtn_red.hidden = YES;
    if ([model_discount isEqualToString:@"0"] && [model_yellow_discount isEqualToString:@"0"] && [model_blue_discount isEqualToString:@"0"]) {
        return;
    }
    SPayChoice * payChoice = [[SPayChoice alloc] init];
    payChoice.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    payChoice.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:payChoice animated:YES completion:nil];

    if ([model_discount isEqualToString:@"0"]) {
        payChoice.redBtn_HHH.constant = 0;
        payChoice.redBtn.hidden = YES;
        payChoice.red_des.hidden = YES;
        payChoice.redDes_HHH.constant = 0;
    }
    if ([model_yellow_discount isEqualToString:@"0"]) {
        payChoice.yellowBtn_HHH.constant = 0;
        payChoice.yellowBtn.hidden = YES;
        payChoice.yellow_des.hidden = YES;
        payChoice.yellowDes_HHH.constant = 0;
    }
    if ([model_blue_discount isEqualToString:@"0"]) {
        payChoice.blueBtn.hidden = YES;
        payChoice.blue_des.hidden = YES;
    }
    payChoice.red_des.text = red_desc;
    payChoice.yellow_des.text = yellow_desc;
    payChoice.blue_des.text = blue_desc;
    
    //单商品
    payChoice.SPayChoice_choice = ^(NSInteger num) {
        _oneBtn_red.hidden = NO;
        if (num == 0) {
            _oneBtn_red.image = [UIImage imageNamed:@"代金券红"];
            discount_type = @"1";
            _thisMoney.text = [NSString stringWithFormat:@"￥%.2f",[_numTF.text integerValue] * [_money floatValue] - [model_discount_price floatValue]];
        } else if (num == 1) {
            _oneBtn_red.image = [UIImage imageNamed:@"代金券黄"];
            discount_type = @"2";
            _thisMoney.text = [NSString stringWithFormat:@"￥%.2f",[_numTF.text integerValue] * [_money floatValue] - [model_yellow_discount_price floatValue]];
        } else if (num == 2) {
            _oneBtn_red.image = [UIImage imageNamed:@"代金券蓝"];
            discount_type = @"3";
            _thisMoney.text = [NSString stringWithFormat:@"￥%.2f",[_numTF.text integerValue] * [_money floatValue] - [model_blue_discount_price floatValue]];
        } else if (num == 3) {
            _oneBtn_red.hidden = YES;
            discount_type = @"0";
            _thisMoney.text = [NSString stringWithFormat:@"￥%.2f",[_numTF.text integerValue] * [_money floatValue]];

        }
    };
}
#pragma mark - 支付宝支付
- (IBAction)twoBtn:(UIButton *)sender {
    payType = @"3";
    _thisMoney.text = [NSString stringWithFormat:@"￥%.2f",[_numTF.text integerValue] * [_money floatValue]];
    [_oneBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    [_twoBtn setImage:[UIImage imageNamed:@"R选中"] forState:UIControlStateNormal];
    [_threeBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    [_fourBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    
    _oneBtn_blue.hidden = YES;
    _oneBtn_yellow.hidden = YES;
    _oneBtn_red.hidden = YES;
    
    _twoBtn_blue.hidden = YES;
    _twoBtn_yellow.hidden = YES;
    _twoBtn_red.hidden = YES;
    
    _threeBtn_blue.hidden = YES;
    _threeBtn_yellow.hidden = YES;
    _threeBtn_red.hidden = YES;
    if ([model_discount isEqualToString:@"0"] && [model_yellow_discount isEqualToString:@"0"] && [model_blue_discount isEqualToString:@"0"]) {
        return;
    }
    SPayChoice * payChoice = [[SPayChoice alloc] init];
    payChoice.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    payChoice.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:payChoice animated:YES completion:nil];
    
    if ([model_discount isEqualToString:@"0"]) {
        payChoice.redBtn_HHH.constant = 0;
        payChoice.redBtn.hidden = YES;
        payChoice.red_des.hidden = YES;
        payChoice.redDes_HHH.constant = 0;
    }
    if ([model_yellow_discount isEqualToString:@"0"]) {
        payChoice.yellowBtn_HHH.constant = 0;
        payChoice.yellowBtn.hidden = YES;
        payChoice.yellow_des.hidden = YES;
        payChoice.yellowDes_HHH.constant = 0;
    }
    if ([model_blue_discount isEqualToString:@"0"]) {
        payChoice.blueBtn.hidden = YES;
        payChoice.blue_des.hidden = YES;
    }
    payChoice.red_des.text = red_desc;
    payChoice.yellow_des.text = yellow_desc;
    payChoice.blue_des.text = blue_desc;
    
    //单商品
    payChoice.SPayChoice_choice = ^(NSInteger num) {
        _twoBtn_red.hidden = NO;
        if (num == 0) {
            _twoBtn_red.image = [UIImage imageNamed:@"代金券红"];
            discount_type = @"1";
            _thisMoney.text = [NSString stringWithFormat:@"￥%.2f",[_numTF.text integerValue] * [_money floatValue] - [model_discount_price floatValue]];
            
        } else if (num == 1) {
            _twoBtn_red.image = [UIImage imageNamed:@"代金券黄"];
            discount_type = @"2";
            _thisMoney.text = [NSString stringWithFormat:@"￥%.2f",[_numTF.text integerValue] * [_money floatValue] - [model_yellow_discount_price floatValue]];
            
        } else if (num == 2) {
            _twoBtn_red.image = [UIImage imageNamed:@"代金券蓝"];
            discount_type = @"3";
            _thisMoney.text = [NSString stringWithFormat:@"￥%.2f",[_numTF.text integerValue] * [_money floatValue] - [model_blue_discount_price floatValue]];
        } else if (num == 3) {
            _twoBtn_red.hidden = YES;
            discount_type = @"0";
            _thisMoney.text = [NSString stringWithFormat:@"￥%.2f",[_numTF.text integerValue] * [_money floatValue]];
        }
    };
}
#pragma mark - 微信支付
- (IBAction)threeBtn:(UIButton *)sender {
    payType = @"4";
    _thisMoney.text = [NSString stringWithFormat:@"￥%.2f",[_numTF.text integerValue] * [_money floatValue]];
    [_oneBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    [_twoBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    [_threeBtn setImage:[UIImage imageNamed:@"R选中"] forState:UIControlStateNormal];
    [_fourBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    
    _oneBtn_blue.hidden = YES;
    _oneBtn_yellow.hidden = YES;
    _oneBtn_red.hidden = YES;
    
    _twoBtn_blue.hidden = YES;
    _twoBtn_yellow.hidden = YES;
    _twoBtn_red.hidden = YES;
    
    _threeBtn_blue.hidden = YES;
    _threeBtn_yellow.hidden = YES;
    _threeBtn_red.hidden = YES;
    if ([model_discount isEqualToString:@"0"] && [model_yellow_discount isEqualToString:@"0"] && [model_blue_discount isEqualToString:@"0"]) {
        return;
    }
    SPayChoice * payChoice = [[SPayChoice alloc] init];
    payChoice.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    payChoice.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:payChoice animated:YES completion:nil];
    

    if ([model_discount isEqualToString:@"0"]) {
        payChoice.redBtn_HHH.constant = 0;
        payChoice.redBtn.hidden = YES;
        payChoice.red_des.hidden = YES;
        payChoice.redDes_HHH.constant = 0;
    }
    if ([model_yellow_discount isEqualToString:@"0"]) {
        payChoice.yellowBtn_HHH.constant = 0;
        payChoice.yellowBtn.hidden = YES;
        payChoice.yellow_des.hidden = YES;
        payChoice.yellowDes_HHH.constant = 0;
    }
    if ([model_blue_discount isEqualToString:@"0"]) {
        payChoice.blueBtn.hidden = YES;
        payChoice.blue_des.hidden = YES;
    }
    payChoice.red_des.text = red_desc;
    payChoice.yellow_des.text = yellow_desc;
    payChoice.blue_des.text = blue_desc;
    
    //单商品
    payChoice.SPayChoice_choice = ^(NSInteger num) {
        _threeBtn_red.hidden = NO;
        if (num == 0) {
            _threeBtn_red.image = [UIImage imageNamed:@"代金券红"];
            discount_type = @"1";
            _thisMoney.text = [NSString stringWithFormat:@"￥%.2f",[_numTF.text integerValue] * [_money floatValue] - [model_discount_price floatValue]];
            
        } else if (num == 1) {
            _threeBtn_red.image = [UIImage imageNamed:@"代金券黄"];
            discount_type = @"2";
            _thisMoney.text = [NSString stringWithFormat:@"￥%.2f",[_numTF.text integerValue] * [_money floatValue] - [model_yellow_discount_price floatValue]];
            
        } else if (num == 2) {
            _threeBtn_red.image = [UIImage imageNamed:@"代金券蓝"];
            discount_type = @"3";
            _thisMoney.text = [NSString stringWithFormat:@"￥%.2f",[_numTF.text integerValue] * [_money floatValue] - [model_blue_discount_price floatValue]];
            
        } else if (num == 3) {
            _threeBtn_red.hidden = YES;
            discount_type = @"0";
            _thisMoney.text = [NSString stringWithFormat:@"￥%.2f",[_numTF.text integerValue] * [_money floatValue]];
        }
    };
}
#pragma mark - 积分支付
- (IBAction)fourBtn:(UIButton *)sender {
    discount_type = @"0";
    payType = @"2";
    _thisMoney.text = [NSString stringWithFormat:@"%.2f积分",[_numTF.text integerValue] * [integral_price floatValue]];
    [_oneBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    [_twoBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    [_threeBtn setImage:[UIImage imageNamed:@"R默认"] forState:UIControlStateNormal];
    [_fourBtn setImage:[UIImage imageNamed:@"R选中"] forState:UIControlStateNormal];
    
    _oneBtn_blue.hidden = YES;
    _oneBtn_yellow.hidden = YES;
    _oneBtn_red.hidden = YES;
    
    _twoBtn_blue.hidden = YES;
    _twoBtn_yellow.hidden = YES;
    _twoBtn_red.hidden = YES;
    
    _threeBtn_blue.hidden = YES;
    _threeBtn_yellow.hidden = YES;
    _threeBtn_red.hidden = YES;
}
- (IBAction)agreementBtn:(UIButton *)sender {
    SMessageInfor * infor = [[SMessageInfor alloc] init];
    infor.type = @"会员卡";
    [self.navigationController pushViewController:infor animated:YES];
}
- (IBAction)submitBtn:(UIButton *)sender {
    if (payType == nil) {
        [MBProgressHUD showError:@"请选择支付方式" toView:self.view];
        return;
    }
    if ([payType isEqualToString:@"3"]||[payType isEqualToString:@"4"]) {
        [self showTypeComing];
    }
    else
    {
    SUserSetting * set = [[SUserSetting alloc] init];
    [set sUserSettingSuccess:^(NSString *code, NSString *message, id data) {
        SUserSetting * set = (SUserSetting *)data;
        if ([set.data.is_pay_password integerValue] == 0) {
            [MBProgressHUD showError:@"请先设置支付密码" toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                SModifyLoginPassword * logPass = [[SModifyLoginPassword alloc] init];
                logPass.type = YES;
                logPass.set_type = NO;
                [self.navigationController pushViewController:logPass animated:YES];
            });
        } else {
            [self showTypeComing];
        }
    } andFailure:^(NSError *error) {
    }];}
}
- (void)showTypeComing {
    if ([payType isEqualToString:@"1"]||[payType isEqualToString:@"2"]) {
     
    if (payPass_isno == NO) {
        SPay_Pass * pass = [[SPay_Pass alloc] init];
        pass.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        pass.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [self.navigationController presentViewController:pass animated:YES completion:nil];
        pass.SPay_Pass_back = ^{
            payPass_isno = YES;
            UIButton * btn;
            [self submitBtn:btn];
        };
        pass.SPay_Pass_set = ^{
            SModifyLoginPassword * logPass = [[SModifyLoginPassword alloc] init];
            logPass.type = YES;
            logPass.set_type = NO;
            [self.navigationController pushViewController:logPass animated:YES];
        };
        return;
    }
    }
    payPass_isno = NO;
    
    SMemberOrderSetOrder * pay = [[SMemberOrderSetOrder alloc] init];
    pay.member_coding = _member_coding;
    pay.number = _numTF.text;
    pay.discount_type = discount_type;
    pay.pay_type = payType;
    pay.order_id = _order_id;
    [MBProgressHUD showMessage:nil toView:self.view];
    [pay sMemberOrderSetOrderSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            if ([payType isEqualToString:@"1"] || [payType isEqualToString:@"2"]) {
                //余额支付、积分支付
                [MBProgressHUD showSuccess:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    //                    [self.navigationController popToViewController:_grade animated:YES];
                    SMemberOrder * list = [[SMemberOrder alloc] init];
                    list.coming = YES;
                    list.type = @"会员卡";
                    [self.navigationController pushViewController:list animated:YES];
                });
            }
            if ([payType isEqualToString:@"3"]) {
                //支付宝支付
                SMemberOrderSetOrder * pay = (SMemberOrderSetOrder *)data;
                order_id = pay.data.order_id;
                [[SNPayManager sharePayManager] sn_openTheAlipayOrderString:pay.data.pay_string WithServicePay:^(NSError *error) {
                    if (error) {
                        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            //                    [self.navigationController popToViewController:_grade animated:YES];
                            SMemberOrder * list = [[SMemberOrder alloc] init];
                            list.coming = YES;
                            list.type = @"会员卡";
                            [self.navigationController pushViewController:list animated:YES];
                        });
                    } else {
                        //支付结果查询
                        [self payShow];
                    }
                }];
            }
            if ([payType isEqualToString:@"4"]) {
                //微信支付
                SMemberOrderSetOrder * pay = (SMemberOrderSetOrder *)data;
                order_id = pay.data.order_id;
                
                SNPayManager * manager = [SNPayManager sharePayManager];
                manager.wxPartnerId = pay.data.mch_id;//商户号
                manager.wxPrepayId = pay.data.prepay_id;//预支付id
                manager.wxNonceStr = pay.data.nonce_str;//随机字符串
                manager.wxTimeStamp = pay.data.time_stamp;//时间戳
                manager.wxSign = pay.data.sign;//签名
                [manager sn_openTheWechatWithServicePay:^(NSError *error) {
                    if (error) {
                        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            //                    [self.navigationController popToViewController:_grade animated:YES];
                            SMemberOrder * list = [[SMemberOrder alloc] init];
                            list.coming = YES;
                            list.type = @"会员卡";
                            [self.navigationController pushViewController:list animated:YES];
                        });
                    } else {
                        //支付结果查询
                        [self payShow];
                    }
                }];
            }
            
        } else {
            [MBProgressHUD showError:message toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //                    [self.navigationController popToViewController:_grade animated:YES];
                SMemberOrder * list = [[SMemberOrder alloc] init];
                list.coming = YES;
                list.type = @"会员卡";
                [self.navigationController pushViewController:list animated:YES];
            });
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //                    [self.navigationController popToViewController:_grade animated:YES];
            SMemberOrder * list = [[SMemberOrder alloc] init];
            list.coming = YES;
            list.type = @"会员卡";
            [self.navigationController pushViewController:list animated:YES];
        });
    }];
}
- (void)payShow {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    SMemberAliPayFindPayResult * result = [[SMemberAliPayFindPayResult alloc] init];
    result.order_id = order_id;
    result.type = @"1";
    [MBProgressHUD showMessage:nil toView:self.view];
    [result sMemberAliPayFindPayResultSuccess:^(NSString *code, NSString *message) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            [MBProgressHUD showSuccess:message toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [self.navigationController popToViewController:_grade animated:YES];
                SMemberOrder * list = [[SMemberOrder alloc] init];
                list.coming = YES;
                list.type = @"会员卡";
                [self.navigationController pushViewController:list animated:YES];
            });
        } else {
            [MBProgressHUD showError:message toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //                    [self.navigationController popToViewController:_grade animated:YES];
                SMemberOrder * list = [[SMemberOrder alloc] init];
                list.coming = YES;
                list.type = @"会员卡";
                [self.navigationController pushViewController:list animated:YES];
            });
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //                    [self.navigationController popToViewController:_grade animated:YES];
            SMemberOrder * list = [[SMemberOrder alloc] init];
            list.coming = YES;
            list.type = @"会员卡";
            [self.navigationController pushViewController:list animated:YES];
        });
    }];
    
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    _numTF.text = [NSString stringWithFormat:@"%ld",[textField.text integerValue] != 0 ? [textField.text integerValue] : 1];
    _thisMoney.text = [NSString stringWithFormat:@"￥%.2f",[_numTF.text integerValue] * [_money floatValue]];
    [self showModel_sub];

    return YES;
}
- (IBAction)num_leftBtn:(UIButton *)sender {
    if ([_numTF.text integerValue] == 1) {
        return;
    }
    _numTF.text = [NSString stringWithFormat:@"%ld",[_numTF.text integerValue] - 1];
    if (![payType isEqualToString:@"2"]) {
        //余额、支付宝、微信支付
        _thisMoney.text = [NSString stringWithFormat:@"￥%.2f",[_numTF.text integerValue] * [_money floatValue]];
    } else {
        //积分支付
        _thisMoney.text = [NSString stringWithFormat:@"%.2f积分",[_numTF.text integerValue] * [integral_price floatValue]];
    }
    [self showModel_sub];

}
- (IBAction)num_rightBtn:(UIButton *)sender {
    _numTF.text = [NSString stringWithFormat:@"%ld",[_numTF.text integerValue] + 1];
    if (![payType isEqualToString:@"2"]) {
        //余额、支付宝、微信支付
        _thisMoney.text = [NSString stringWithFormat:@"￥%.2f",[_numTF.text integerValue] * [_money floatValue]];
    } else {
        //积分支付
        _thisMoney.text = [NSString stringWithFormat:@"%.2f积分",[_numTF.text integerValue] * [integral_price floatValue]];
    }
    [self showModel_sub];

}
- (void)showModel_sub  {
    SMemberOrderTicket * ticket = [[SMemberOrderTicket alloc] init];
    ticket.member_coding = _member_coding;
    ticket.number = _numTF.text;
    [ticket sMemberOrderTicketSuccess:^(NSString *code, NSString *message, id data) {
        SMemberOrderTicket * ticket = (SMemberOrderTicket *)data;
        model_discount = ticket.data.discount;
        model_yellow_discount = ticket.data.yellow_discount;
        model_blue_discount = ticket.data.blue_discount;
        red_desc = ticket.data.red_desc;
        yellow_desc = ticket.data.yellow_desc;
        blue_desc = ticket.data.blue_desc;
        model_discount_price = ticket.data.discount_price;
        model_yellow_discount_price = ticket.data.yellow_price;
        model_blue_discount_price = ticket.data.blue_price;

    } andFailure:^(NSError *error) {
        
    }];
}
@end
