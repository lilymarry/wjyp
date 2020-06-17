//
//  SResetPayPass.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/21.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SResetPayPass.h"
#import "SResetPayPass_sub.h"
#import "SRegisterSendVerify.h"

@interface SResetPayPass ()

@property (strong, nonatomic) IBOutlet UITextField *iPhoneTF;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@end

@implementation SResetPayPass

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    /*
     *显示默认设置的手机号
     */
    _iPhoneTF.text = self.iPhone;
    
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 3;
    [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    if (_setttt != nil) {
        self.title = @"重置支付密码";
        /*
         *设置默认手机号不可编辑
         */
        self.iPhoneTF.userInteractionEnabled = NO;
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
- (void)submitBtnClick {
    SRegisterSendVerify * ver = [[SRegisterSendVerify alloc] init];
    ver.phone = _iPhoneTF.text;
    if (_setttt != nil) {
        ver.type = @"re_pay_pwd";
    } else {
        ver.type = @"retrieve";
    }
    [MBProgressHUD showMessage:nil toView:self.view];
    [ver sRegisterSendVerifySuccess:^(NSString *code, NSString *message) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            SResetPayPass_sub * pay = [[SResetPayPass_sub alloc] init];
            pay.setttt = _setttt;
            pay.landddd = _landddd;
            pay.iPhone = _iPhoneTF.text;
            [self.navigationController pushViewController:pay animated:YES];
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
}
@end
