//
//  SModifyLoginPassword.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/21.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SModifyLoginPassword.h"
#import "SResetPayPass.h"

//设置登录密码
#import "SUserSetPassword.h"
//修改登录密码
#import "SUserChangePassword.h"
//设置密码密码
#import "SUserSetPayPwd.h"
//修改支付密码
#import "SUserRePayPwd.h"

@interface SModifyLoginPassword ()

@property (strong, nonatomic) IBOutlet UIView *oneView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *oneView_HHH;
@property (strong, nonatomic) IBOutlet UITextField *oneTF;
@property (strong, nonatomic) IBOutlet UIButton *twoBtn;
@property (strong, nonatomic) IBOutlet UITextField *twoTF;
@property (strong, nonatomic) IBOutlet UIButton *threeBtn;
@property (strong, nonatomic) IBOutlet UITextField *threeTF;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong, nonatomic) IBOutlet UIButton *forGetBtn;
@end

@implementation SModifyLoginPassword

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _twoTF.secureTextEntry = YES;
    [_twoBtn addTarget:self action:@selector(twoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    xib中设置代码 此处去掉 by_fxg
//    [_twoBtn setTag:0];
    
    _threeTF.secureTextEntry = YES;
    [_threeBtn addTarget:self action:@selector(threeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//    xib中设置代码 此处去掉 by_fxg
//    [_threeBtn setTag:0];
    
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 3;
    [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_forGetBtn addTarget:self action:@selector(forGetBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    if (_type == NO) {
        if (_set_type == NO) {
            self.title = @"设置登录密码";
        } else {
            self.title = @"修改登录密码";
        }
        _forGetBtn.hidden = YES;
    } else {
        if (_set_type == NO) {
            self.title = @"设置支付密码";
        } else {
            self.title = @"修改支付密码";
        }
        _forGetBtn.hidden = NO;
    }
    if (_set_type == NO) {
        _oneView.hidden = YES;
        _oneView_HHH.constant = 0;
        _forGetBtn.hidden = YES;
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
#pragma mark - 新密码可见
- (void)twoBtnClick:(UIButton *)btn {
    if (btn.tag == 0) {
        [btn setImage:[UIImage imageNamed:@"闭眼"] forState:UIControlStateNormal];
        _twoTF.secureTextEntry = YES;
        [btn setTag:1];
    } else {
        [btn setImage:[UIImage imageNamed:@"睁眼"] forState:UIControlStateNormal];
        _twoTF.secureTextEntry = NO;
        [btn setTag:0];
    }
}
#pragma mark - 重复新密码可见
- (void)threeBtnClick:(UIButton *)btn {
    if (btn.tag == 0) {
        [btn setImage:[UIImage imageNamed:@"闭眼"] forState:UIControlStateNormal];
        _threeTF.secureTextEntry = YES;
        [btn setTag:1];
    } else {
        [btn setImage:[UIImage imageNamed:@"睁眼"] forState:UIControlStateNormal];
        _threeTF.secureTextEntry = NO;
        [btn setTag:0];
    }
}
- (void)submitBtnClick {
    if (_type == NO) {
        //登录密码
        if (_set_type == NO) {
            SUserSetPassword * set = [[SUserSetPassword alloc] init];
            set.thisNewPassword = _twoTF.text;
            set.rePassword = _threeTF.text;
//            [MBProgressHUD showMessage:nil toView:self.view];
            [set sUserSetPasswordSuccess:^(NSString *code, NSString *message) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([code isEqualToString:@"1"]) {
                    [MBProgressHUD showSuccess:message toView:self.view];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        [self.navigationController popViewControllerAnimated:YES];
                        [[SRegisterLogin shareInstance] deleteUserInfo];
                        EMError *error = [[EMClient sharedClient] logout:YES];
                        SLand * land = [[SLand alloc] init];
                        UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
                        self.view.window.rootViewController = landNav;
                    });
                } else {
                    [MBProgressHUD showError:message toView:self.view];
                }
            } andFailure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            }];
        } else {
            SUserChangePassword * change = [[SUserChangePassword alloc] init];
            change.oldPassword = _oneTF.text;
            change.thisNewPassword = _twoTF.text;
            change.rePassword = _threeTF.text;
            //        [MBProgressHUD showMessage:nil toView:self.view];
            [change sUserChangePasswordSuccess:^(NSString *code, NSString *message) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([code isEqualToString:@"1"]) {
                    [MBProgressHUD showSuccess:message toView:self.view];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                        [self.navigationController popViewControllerAnimated:YES];
                        [[SRegisterLogin shareInstance] deleteUserInfo];
                        EMError *error = [[EMClient sharedClient] logout:YES];
                        SLand * land = [[SLand alloc] init];
                        UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
                        self.view.window.rootViewController = landNav;
                    });
                } else {
                    [MBProgressHUD showError:message toView:self.view];
                }
            } andFailure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            }];
        }
        
    } else {
        //支付密码
        if (_set_type == NO) {
            SUserSetPayPwd * set = [[SUserSetPayPwd alloc] init];
            set.thisNewPayPwd = _twoTF.text;
            set.rePayPwd = _threeTF.text;
//            [MBProgressHUD showMessage:nil toView:self.view];
            [set sUserSetPayPwdSuccess:^(NSString *code, NSString *message) {
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
            SUserRePayPwd * rePay = [[SUserRePayPwd alloc] init];
            rePay.oldPayPwd = _oneTF.text;
            rePay.thisNewPayPwd = _twoTF.text;
            rePay.rePayPwd = _threeTF.text;
//            [MBProgressHUD showMessage:nil toView:self.view];
            [rePay sUserRePayPwdSuccess:^(NSString *code, NSString *message) {
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
    }
}
- (void)forGetBtnClick {
    SResetPayPass * pay = [[SResetPayPass alloc] init];
    pay.setttt = _setttt;
    /*
     *绑定的手机号的传递
     */
    pay.iPhone = self.iPhone;
    [self.navigationController pushViewController:pay animated:YES];
}
@end
