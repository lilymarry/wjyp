//
//  SAccount.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAccount.h"
#import "SNTabBarController.h"//标签栏
#import "SOnlineShop.h"//线上商城
#import "SLineShop.h"//线下商城
#import "SMore.h"//更多
#import "SShopCar.h"//购物车
#import "SMine.h"//我的
#import "CustomLayoutConstraint.h"
#import "SRegisterOtherLoginBind.h"
#import "SRegisterSendVerify.h"

@interface SAccount ()
{
    int secondsCountDown; //倒计时总时长
    NSTimer *countDownTimer;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeightLayout;
@property (strong, nonatomic) IBOutlet UIButton *vcBtn;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong, nonatomic) IBOutlet UITextField *iPhoneTF;
@property (strong, nonatomic) IBOutlet UITextField *vcNumTF;
@end

@implementation SAccount

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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"账号绑定";
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
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"绑定账号后，方可正常登录" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark - 发送验证码
- (void)vcBtnClick {
    SRegisterSendVerify * send = [[SRegisterSendVerify alloc] init];
    send.phone = _iPhoneTF.text;
    send.type = @"re_bind";
    [send sRegisterSendVerifySuccess:^(NSString *code, NSString *message) {
        if ([code isEqualToString:@"1"]) {
            secondsCountDown = 60;//60秒倒计时
            countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 timeFireMethod
            _vcBtn.enabled = NO;
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];

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
    SRegisterOtherLoginBind * other = [[SRegisterOtherLoginBind alloc] init];
    other.bind_id = _bind_id;
    other.phone = _iPhoneTF.text;
    other.verify = _vcNumTF.text;
    other.invite_code = @"";
    [MBProgressHUD showMessage:nil toView:self.view];
    [other sRegisterOtherLoginBindSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            [MBProgressHUD showSuccess:message toView:self.view];
            SRegisterOtherLoginBind * other = (SRegisterOtherLoginBind *)data;
            [[SRegisterLogin shareInstance] save:other.data];
            BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
            if (!isAutoLogin) {
                EMError *error = [[EMClient sharedClient] loginWithUsername:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].easemob_account password:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].easemob_pwd];
                if (!error) {
                    NSLog(@"登录成功");
                    [[EMClient sharedClient].options setIsAutoLogin:YES];
                }
            }
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self landSuccess];
            });
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
#pragma mark - 登录成功
- (void)landSuccess {
    
//    SOnlineShop * vc1 = [[SOnlineShop alloc] init];
//    vc1.tabBarItem.title = @"线上商城";
//    vc1.tabBarItem.image = [UIImage imageNamed:@"线上商城默认"];
//    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"线上商城选中"];
//
//    SLineShop * vc2 = [[SLineShop alloc] init];
//    vc2.tabBarItem.title = @"线下店铺";
//    vc2.tabBarItem.image = [UIImage imageNamed:@"线下商城默认"];
//    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"线下商城选中"];
//
//    SMore * vc3 = [[SMore alloc] init];
//    vc3.tabBarItem.title = @"更多";
//    vc3.tabBarItem.image = [UIImage imageNamed:@"更多选中"];
//    vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"更多选中"];
//
//    SShopCar * vc4 = [[SShopCar alloc] init];
//    vc4.tabBarItem.title = @"购物车";
//    vc4.tabBarItem.image = [UIImage imageNamed:@"购物车默认"];
//    vc4.tabBarItem.selectedImage = [UIImage imageNamed:@"购物车选中"];
//
//    SMine * vc5 = [[SMine alloc] init];
//    vc5.tabBarItem.title = @"我的";
//    vc5.tabBarItem.image = [UIImage imageNamed:@"我的默认"];
//    vc5.tabBarItem.selectedImage = [UIImage imageNamed:@"我的选中"];
//
//    UINavigationController * nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
//    UINavigationController * nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
//    UINavigationController * nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
//    UINavigationController * nav4 = [[UINavigationController alloc] initWithRootViewController:vc4];
//    UINavigationController * nav5 = [[UINavigationController alloc] initWithRootViewController:vc5];
    
    SNTabBarController * tabBarController = [[SNTabBarController alloc] init];
    
//    tabBarController.itemImageScale = 0.6;
//    tabBarController.tabBarBgColor = [UIColor blackColor];
//    tabBarController.normalItemColor = [UIColor blackColor];
//    tabBarController.selectedItemColor = [UIColor blackColor];
//    tabBarController.itemFont = [UIFont systemFontOfSize:10];
//    tabBarController.defaultSelectedIndex = 0;
//    
//    tabBarController.viewControllers = @[nav1,nav2,nav3,nav4,nav5];
    self.view.window.rootViewController = tabBarController;
}
@end
