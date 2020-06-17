//
//  SRegisterTwo.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SRegisterTwo.h"
#import "SNTabBarController.h"//标签栏
#import "SOnlineShop.h"//线上商城
#import "SLineShop.h"//线下商城
#import "SMore.h"//更多
#import "SShopCar.h"//购物车
#import "SMine.h"//我的
#import "CustomLayoutConstraint.h"
#import "SRegisterRegister.h"

@interface SRegisterTwo ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeightLayout;
@property (strong, nonatomic) IBOutlet UITextField *oneTF;
@property (strong, nonatomic) IBOutlet UIButton *oneBtn;
@property (strong, nonatomic) IBOutlet UITextField *twoTF;
@property (strong, nonatomic) IBOutlet UIButton *twoBtn;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation SRegisterTwo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    _oneTF.secureTextEntry = YES;
    [_oneBtn addTarget:self action:@selector(oneBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_oneBtn setTag:0];
    
    _twoTF.secureTextEntry = YES;
    [_twoBtn addTarget:self action:@selector(twoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_twoBtn setTag:0];
    
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
    
    self.title = @"设置密码";
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

#pragma mark - 新密码可见
- (void)oneBtnClick:(UIButton *)btn {
    if (btn.tag == 0) {
        [btn setImage:[UIImage imageNamed:@"闭眼"] forState:UIControlStateNormal];
        _oneTF.secureTextEntry = NO;
        [btn setTag:1];
    } else {
        [btn setImage:[UIImage imageNamed:@"睁眼"] forState:UIControlStateNormal];
        _oneTF.secureTextEntry = YES;
        [btn setTag:0];
    }
}
#pragma mark - 重复新密码可见
- (void)twoBtnClick:(UIButton *)btn {
    if (btn.tag == 0) {
        [btn setImage:[UIImage imageNamed:@"闭眼"] forState:UIControlStateNormal];
        _twoTF.secureTextEntry = NO;
        [btn setTag:1];
    } else {
        [btn setImage:[UIImage imageNamed:@"睁眼"] forState:UIControlStateNormal];
        _twoTF.secureTextEntry = YES;
        [btn setTag:0];
    }
}
- (void)submitBtnClick {
    [self landSuccess];
}

#pragma mark - 登录成功
- (void)landSuccess {
    
    SRegisterRegister * regist = [[SRegisterRegister alloc] init];
    regist.phone = _phone;
    regist.password = _oneTF.text;
    regist.confirmPassword = _twoTF.text;
    if (_invite_code != nil) {
        regist.invite_code = _invite_code;
    } else {
        regist.invite_code = @"";
    }
    [MBProgressHUD showMessage:nil toView:self.view];
    [regist sRegisterRegisterSuccess:^(NSString *code, NSString *message) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            [MBProgressHUD showSuccess:message toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                SRegisterLogin * regLogin = [[SRegisterLogin alloc] init];
                regLogin.phone = _phone;
                regLogin.password = _twoTF.text;
                [regLogin sRegisterLoginSuccess:^(NSString *code, NSString *message, id data) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    if ([code isEqualToString:@"1"]) {
                        [MBProgressHUD showSuccess:message toView:self.view];
                        SRegisterLogin * login = (SRegisterLogin *)data;
                        [regLogin save:login.data];
                        BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
                        if (!isAutoLogin) {
                            EMError *error = [[EMClient sharedClient] loginWithUsername:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].easemob_account password:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].easemob_pwd];
                            if (!error) {
                                NSLog(@"登录成功");
                                [[EMClient sharedClient].options setIsAutoLogin:YES];
                            }
                        }
                        //记住密码
                        [[NSUserDefaults standardUserDefaults] setObject:_phone forKey:@"user_account"];
                        [[NSUserDefaults standardUserDefaults] setObject:_twoTF.text forKey:@"user_password"];
                        
//                        SOnlineShop * vc1 = [[SOnlineShop alloc] init];
//                        vc1.tabBarItem.title = @"线上商城";
//                        vc1.tabBarItem.image = [UIImage imageNamed:@"线上商城默认"];
//                        vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"线上商城选中"];
//
//                        SLineShop * vc2 = [[SLineShop alloc] init];
//                        vc2.tabBarItem.title = @"线下店铺";
//                        vc2.tabBarItem.image = [UIImage imageNamed:@"线下商城默认"];
//                        vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"线下商城选中"];
//
//                        SMore * vc3 = [[SMore alloc] init];
//                        vc3.tabBarItem.title = @"更多";
//                        vc3.tabBarItem.image = [UIImage imageNamed:@"更多选中"];
//                        vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"更多选中"];
//
//                        SShopCar * vc4 = [[SShopCar alloc] init];
//                        vc4.tabBarItem.title = @"购物车";
//                        vc4.tabBarItem.image = [UIImage imageNamed:@"购物车默认"];
//                        vc4.tabBarItem.selectedImage = [UIImage imageNamed:@"购物车选中"];
//
//                        SMine * vc5 = [[SMine alloc] init];
//                        vc5.tabBarItem.title = @"我的";
//                        vc5.tabBarItem.image = [UIImage imageNamed:@"我的默认"];
//                        vc5.tabBarItem.selectedImage = [UIImage imageNamed:@"我的选中"];
//
//                        UINavigationController * nav1 = [[UINavigationController alloc] initWithRootViewController:vc1];
//                        UINavigationController * nav2 = [[UINavigationController alloc] initWithRootViewController:vc2];
//                        UINavigationController * nav3 = [[UINavigationController alloc] initWithRootViewController:vc3];
//                        UINavigationController * nav4 = [[UINavigationController alloc] initWithRootViewController:vc4];
//                        UINavigationController * nav5 = [[UINavigationController alloc] initWithRootViewController:vc5];
                        
                        SNTabBarController * tabBarController = [[SNTabBarController alloc] init];
                        
//                        tabBarController.itemImageScale = 0.6;
//                        tabBarController.tabBarBgColor = [UIColor blackColor];
//                        tabBarController.normalItemColor = [UIColor blackColor];
//                        tabBarController.selectedItemColor = [UIColor blackColor];
//                        tabBarController.itemFont = [UIFont systemFontOfSize:10];
//                        tabBarController.defaultSelectedIndex = 0;
//                        
//                        tabBarController.viewControllers = @[nav1,nav2,nav3,nav4,nav5];
                        self.view.window.rootViewController = tabBarController;
                    } else {
                        [MBProgressHUD showError:message toView:self.view];
                    }
                } andFailure:^(NSError *error) {
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                }];
                
                
                
            });
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
@end
