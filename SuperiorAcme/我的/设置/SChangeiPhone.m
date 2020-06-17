//
//  SChangeiPhone.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/21.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SChangeiPhone.h"

#import "SRegisterSendVerify.h"
#import "SRegisterCheckVerify.h"
#import "SRegisterOtherLoginBind.h"//绑定手机号
#import "SUserChangePhone.h"//换绑手机号

@interface SChangeiPhone ()
{
    int secondsCountDown; //倒计时总时长
    NSTimer *countDownTimer;
    BOOL type;//YES 旧手机号已验证，准备更换新手机号
}
@property (strong, nonatomic) IBOutlet UIButton *vcBtn;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong, nonatomic) IBOutlet UITextField *iPhoneTF;
@property (strong, nonatomic) IBOutlet UITextField *vcNumTF;
@end

@implementation SChangeiPhone

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _vcBtn.layer.masksToBounds = YES;
    _vcBtn.layer.cornerRadius = 3;
    [_vcBtn addTarget:self action:@selector(vcBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 3;
    [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    if (_typeBind == YES) {
        _iPhoneTF.userInteractionEnabled = NO;
        _iPhoneTF.text = _iPhone;
    } else {
        [_submitBtn setTitle:@"完成" forState:UIControlStateNormal];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"换绑手机";
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
#pragma mark - 发送验证码
- (void)vcBtnClick {
    if (_typeBind == NO) {
        //未绑定手机号
        SRegisterSendVerify * ver = [[SRegisterSendVerify alloc] init];
        ver.phone = _iPhoneTF.text;
        ver.type = @"re_bind";
        [MBProgressHUD showMessage:nil toView:self.view];
        [ver sRegisterSendVerifySuccess:^(NSString *code, NSString *message) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                secondsCountDown = 60;//60秒倒计时
                countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 timeFireMethod
                _vcBtn.enabled = NO;
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else {
        if (type == NO) {
            SRegisterSendVerify * ver = [[SRegisterSendVerify alloc] init];
            ver.phone = _iPhoneTF.text;
            ver.type = @"mod_bind";
            [MBProgressHUD showMessage:nil toView:self.view];
            [ver sRegisterSendVerifySuccess:^(NSString *code, NSString *message) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([code isEqualToString:@"1"]) {
                    secondsCountDown = 60;//60秒倒计时
                    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 timeFireMethod
                    _vcBtn.enabled = NO;
                } else {
                    [MBProgressHUD showError:message toView:self.view];
                }
            } andFailure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            }];
        } else {
            SRegisterSendVerify * ver = [[SRegisterSendVerify alloc] init];
            ver.phone = _iPhoneTF.text;
            ver.type = @"re_bind";
            [MBProgressHUD showMessage:nil toView:self.view];
            [ver sRegisterSendVerifySuccess:^(NSString *code, NSString *message) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([code isEqualToString:@"1"]) {
                    secondsCountDown = 60;//60秒倒计时
                    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 timeFireMethod
                    _vcBtn.enabled = NO;
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
-(void)timeFireMethod{
    //倒计时-1
    secondsCountDown--;
    //修改倒计时标签现实内容
    [_vcBtn setTitle:[NSString stringWithFormat:@"%d后重新发送",secondsCountDown] forState:UIControlStateNormal];
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(secondsCountDown==0){
        [countDownTimer invalidate];
        _vcBtn.enabled = YES;
        [_vcBtn setTitle:@"重新发送" forState:UIControlStateNormal];
        [_vcBtn setBackgroundColor:[UIColor redColor]];
    } else {
        _vcBtn.enabled = NO;
        [_vcBtn setBackgroundColor:WordColor_sub_sub];
    }
}
- (void)submitBtnClick {
    [_iPhoneTF resignFirstResponder];
    [_vcNumTF resignFirstResponder];
    if (_typeBind == NO) {
        
        //未绑定手机号
        SRegisterOtherLoginBind * bind = [[SRegisterOtherLoginBind alloc] init];
        bind.bind_id = [[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].user_id;
        bind.phone = _iPhoneTF.text;
        bind.verify = _vcNumTF.text;
        [MBProgressHUD showMessage:nil toView:self.view];
        [bind sRegisterOtherLoginBindSuccess:^(NSString *code, NSString *message, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                [MBProgressHUD showSuccess:message toView:self.view];
                SRegisterOtherLoginBind * other = (SRegisterOtherLoginBind *)data;
                [[SRegisterLogin shareInstance] save:other.data];
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
        //换绑手机号
        if (type == NO) {
            
            SRegisterCheckVerify * check = [[SRegisterCheckVerify alloc] init];
            check.phone = _iPhoneTF.text;
            check.type = @"mod_bind";
            check.verify = _vcNumTF.text;
            [MBProgressHUD showMessage:nil toView:self.view];
            [check sRegisterCheckVerifySuccess:^(NSString *code, NSString *message) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([code isEqualToString:@"1"]) {
                    
                    type = YES;
                    _iPhoneTF.userInteractionEnabled = YES;
                    _iPhoneTF.text = @"";
                    _iPhoneTF.placeholder = @"请输入新手机号";
                    _vcNumTF.text = @"";
                    [_submitBtn setTitle:@"完成" forState:UIControlStateNormal];
                    [countDownTimer invalidate];
                    _vcBtn.enabled = YES;
                    [_vcBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                    [_vcBtn setBackgroundColor:[UIColor redColor]];
                    
                } else {
                    [MBProgressHUD showError:message toView:self.view];
                }
            } andFailure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            }];
            
            
        } else {
            
            SUserChangePhone * chane = [[SUserChangePhone alloc] init];
            chane.thisNewPhone = _iPhoneTF.text;
            chane.verify = _vcNumTF.text;
            [MBProgressHUD showMessage:nil toView:self.view];
            [chane sUserChangePhoneSuccess:^(NSString *code, NSString *message) {
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
@end
