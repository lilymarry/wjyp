//
//  STransferAccounts.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "STransferAccounts.h"
#import "SUserBalanceGetUserName.h"
#import "SUserBalanceChangeMoney.h"
#import "HttpManager.h"
#import "SUserSetting.h"
#import "SModifyLoginPassword.h"
@interface STransferAccounts () <UITextFieldDelegate>
{
    NSString * model_real_name;
}
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong, nonatomic) IBOutlet UITextField *codeTF;
@property (strong, nonatomic) IBOutlet UITextField *real_nameTF;
@property (strong, nonatomic) IBOutlet UITextField *moneyTF;
@property (strong, nonatomic) IBOutlet UITextField *pay_passwordTF;
@property (strong, nonatomic) IBOutlet UITextField *balanceTF;
@property (weak, nonatomic) IBOutlet UILabel *toUser;

@property (weak, nonatomic) IBOutlet UIView *toUserInfoView;

@property (weak, nonatomic) IBOutlet UILabel *number;

@property (weak, nonatomic) IBOutlet UILabel *alertTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *toPrice;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *touserViewLayout;

@end

@implementation STransferAccounts

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    if ([_type isEqualToString:@"1"]) {
        
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 3;
        [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        _codeTF.delegate = self;
        model_real_name = @"";
        _balanceTF.text = _nowBalance;
        
    } else {
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 3;
        [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        _codeTF.delegate = self;
        model_real_name = @"";
        _balanceTF.text = _nowBalance;
        
        _codeTF.placeholder = @"请输入收券方ID或手机号";
        _toUser.text = @"收券人";
        _toUserInfoView.hidden = YES;
        
        _touserViewLayout.constant = 0;
        
        _number.text = @"赠送金额";
        _moneyTF.placeholder = @"请输入金额";
        _moneyTF.keyboardType = UIKeyboardTypeNumberPad;
        _alertTitle.text = @"赠送金额必须为整数";
        [_submitBtn setTitle:@"赠送" forState:UIControlStateNormal];
        
    }
    
    _moneyTF.delegate = self;
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField == _moneyTF) {
        _moneyTF.text = [NSString stringWithFormat:@"%.f", fabsf(floorf([textField.text intValue]))];
    }
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
    
    
    if ([_type isEqualToString:@"1"]) {
        self.title = @"转账";
    } else {
        self.title = @"赠送";
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
- (void)submitBtnClick {
    if ([_type isEqualToString:@"1"]) {
            _submitBtn.enabled=NO   ;
            [self performSelector:@selector(changeButtonStatus)withObject:nil afterDelay:1.5f];//防止重复点击
        SUserBalanceChangeMoney * change = [[SUserBalanceChangeMoney alloc] init];
        change.code = _codeTF.text;
        change.money = _moneyTF.text;
        change.real_name = model_real_name;
        change.pay_password = _pay_passwordTF.text;
        [MBProgressHUD showMessage:nil toView:self.view];
        [change sUserBalanceChangeMoneySuccess:^(NSString *code, NSString *message) {
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
        
    } else {
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
                _submitBtn.enabled=NO   ;
             [self performSelector:@selector(changeButtonStatus)withObject:nil afterDelay:1.5f];//防止重复点击
                [self setPress];
            }
        } andFailure:^(NSError *error) {
        }];
    }
    
    
}
-(void)changeButtonStatus{
   _submitBtn.enabled =YES;
}
-(void)setPress{
    [MBProgressHUD showMessage:nil toView:self.view];
    [HttpManager postWithUrl:SUserBalanceChangeBlueCoupon_Url andParameters:@{@"code":_codeTF.text,@"price":_moneyTF.text,@"pay_password":_pay_passwordTF.text,@"merchant_id":_shopid} andSuccess:^(id Json) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSDictionary * dic = (NSDictionary *)Json;
        if ([dic[@"code"] integerValue] == 1) {
            if (self.changeNowBalance) {
                _balanceTF.text = dic[@"nums"];
                _moneyTF.text = @"";
                _pay_passwordTF.text = @"";
                self.changeNowBalance(dic[@"nums"]);
                [self.navigationController popViewControllerAnimated:YES];
            }
        } else {
        }
        [MBProgressHUD showError:dic[@"message"] toView:self.view];
    } andFail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([_type isEqualToString:@"1"]) {
        
        SUserBalanceGetUserName * userName = [[SUserBalanceGetUserName alloc] init];
        if (textField==_codeTF) {
        userName.code = textField.text;
        [MBProgressHUD showMessage:nil toView:self.view];
        [userName sUserBalanceGetUserNameSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                SUserBalanceGetUserName * userName = (SUserBalanceGetUserName *)data;
                _real_nameTF.text = userName.data.real_name;
                model_real_name = userName.data.real_name;
            } else {
                [MBProgressHUD showError:message toView:self.view];
                _real_nameTF.text = @"";
                model_real_name = @"";
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            _real_nameTF.text = @"";
            model_real_name = @"";
        }];
        
    } else {
        
    }
    }
    
    
    return YES;
}
@end
