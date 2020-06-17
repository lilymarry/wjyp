//
//  SRegisterOne.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SRegisterOne.h"
#import "SRegisterTwo.h"
#import "SRegisterSendVerify.h"
#import "SRegisterCheckVerify.h"
#import "CustomLayoutConstraint.h"

@interface SRegisterOne ()
{
    int secondsCountDown; //倒计时总时长
    NSTimer *countDownTimer;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeightLayout;
@property (strong, nonatomic) IBOutlet UILabel *num;
@property (strong, nonatomic) IBOutlet UITextField *numTF;
@property (strong, nonatomic) IBOutlet UILabel *num_sub;
@property (strong, nonatomic) IBOutlet UIButton *numBtn;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@end

@implementation SRegisterOne

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    
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
    
    self.title = @"请输入验证码";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    //判断是否是iphoneX 做顶部距离约束处理
    [CustomLayoutConstraint layoutIphoneXNavTop:_topHeightLayout];
    
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
    ver.phone = _phone;
    ver.type = @"activate";
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
- (void)submitBtnClick {
    if ([_numTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入短信验证码" toView:self.view];
        return;
    }
    SRegisterCheckVerify * check = [[SRegisterCheckVerify alloc] init];
    check.phone = _phone;
    check.type = @"activate";
    check.verify = _numTF.text;
    [MBProgressHUD showMessage:nil toView:self.view];
    [check sRegisterCheckVerifySuccess:^(NSString *code, NSString *message) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            SRegisterTwo * regTwo = [[SRegisterTwo alloc] init];
            regTwo.phone = _phone;
            regTwo.invite_code = _invite_code;
            [self.navigationController pushViewController:regTwo animated:YES];
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
@end
