//
//  SResetPayPass_sub.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/21.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SResetPayPass_sub.h"
#import "SRegisterSendVerify.h"
#import "SRegisterResetPassword.h"
#import "SUserResetPayPwd.h"

@interface SResetPayPass_sub ()
{
    int secondsCountDown; //倒计时总时长
    NSTimer *countDownTimer;
}
@property (strong, nonatomic) IBOutlet UILabel *num;
@property (strong, nonatomic) IBOutlet UITextField *oneTF;
@property (strong, nonatomic) IBOutlet UILabel *num_sub;
@property (strong, nonatomic) IBOutlet UIButton *numBtn;
@property (strong, nonatomic) IBOutlet UITextField *twoTF;
@property (strong, nonatomic) IBOutlet UIButton *twoBtn;
@property (strong, nonatomic) IBOutlet UITextField *threeTF;
@property (strong, nonatomic) IBOutlet UIButton *threeBtn;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@end

@implementation SResetPayPass_sub

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
    
    secondsCountDown = 60;//60秒倒计时
    countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 timeFireMethod
    _numBtn.enabled = NO;
    
    [_numBtn addTarget:self action:@selector(numBtnClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    if (_setttt != nil) {
        self.title = @"重置支付密码";
    } else {
        self.title = @"重置登录密码";
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
-(void)timeFireMethod{
    //倒计时-1
    secondsCountDown--;
    //修改倒计时标签现实内容
    _num.text = [NSString stringWithFormat:@"%d",secondsCountDown];
    _num_sub.text = @"秒后 重新获取验证码";
    //当倒计时到0时，做需要的操作，比如验证码过期不能提交
    if(secondsCountDown==0){
        [countDownTimer invalidate];
        _num.text = @"";
        _num_sub.text = @"点击重新获取验证码";
        _numBtn.enabled = YES;
    } else {
        _numBtn.enabled = NO;
    }
}
- (void)numBtnClick {
    SRegisterSendVerify * ver = [[SRegisterSendVerify alloc] init];
    ver.phone = _iPhone;
    ver.type = @"retrieve";
    [MBProgressHUD showMessage:nil toView:self.view];
    [ver sRegisterSendVerifySuccess:^(NSString *code, NSString *message) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            secondsCountDown = 60;//60秒倒计时
            countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 timeFireMethod
            _numBtn.enabled = NO;
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
}
#pragma mark - 新密码可见
- (void)twoBtnClick:(UIButton *)btn {
    if (btn.tag == 0) {
        [btn setImage:[UIImage imageNamed:@"闭眼"] forState:UIControlStateNormal];
//        _twoTF.secureTextEntry = NO;
        [btn setTag:1];
    } else {
        [btn setImage:[UIImage imageNamed:@"睁眼"] forState:UIControlStateNormal];
//        _twoTF.secureTextEntry = YES;
        [btn setTag:0];
    }
    _twoTF.secureTextEntry = btn.tag;
}
#pragma mark - 重复新密码可见
- (void)threeBtnClick:(UIButton *)btn {
    if (btn.tag == 0) {
        [btn setImage:[UIImage imageNamed:@"闭眼"] forState:UIControlStateNormal];
//        _threeTF.secureTextEntry = NO;
        [btn setTag:1];
    } else {
        [btn setImage:[UIImage imageNamed:@"睁眼"] forState:UIControlStateNormal];
//        _threeTF.secureTextEntry = YES;
        [btn setTag:0];
    }
    _threeTF.secureTextEntry = btn.tag;
}
- (void)submitBtnClick {
    if (_setttt != nil) {
        //返回个人资料
        SUserResetPayPwd * resetPay = [[SUserResetPayPwd alloc] init];
        resetPay.phone = _iPhone;
        resetPay.verify = _oneTF.text;
        resetPay.thisNewPayPwd = _twoTF.text;
        resetPay.rePayPwd = _threeTF.text;
        [MBProgressHUD showMessage:nil toView:self.view];
        [resetPay sUserResetPayPwdSuccess:^(NSString *code, NSString *message) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                [MBProgressHUD showSuccess:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    //返回个人资料
                    [self.navigationController popToViewController:_setttt animated:YES];

                });
            } else {
                [MBProgressHUD showError:message toView:self.view];
            }
        } andFailure:^(NSError *error) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [MBProgressHUD showError:[error localizedDescription] toView:self.view];
        }];
    } else {
        //返回登录页
        SRegisterResetPassword * resetPass = [[SRegisterResetPassword alloc] init];
        resetPass.phone = _iPhone;
        resetPass.thisNewPassword = _twoTF.text;
        resetPass.confirmPassword = _threeTF.text;
        resetPass.verify = _oneTF.text;
        [MBProgressHUD showMessage:nil toView:self.view];
        [resetPass sRegisterResetPasswordSuccess:^(NSString *code, NSString *message) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if ([code isEqualToString:@"1"]) {
                [MBProgressHUD showSuccess:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    //返回登录
                    [self.navigationController popToViewController:_landddd animated:YES];
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
@end
