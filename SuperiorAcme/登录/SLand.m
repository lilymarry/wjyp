//
//  SLand.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SLand.h"
#import "SNTabBarController.h"//标签栏
#import "SOnlineShop.h"//线上商城
#import "SLineShop.h"//线下商城
#import "SMore.h"//更多
#import "SShopCar.h"//购物车
#import "SMine.h"//我的
#import "SLand_nav.h"
#import "SRegisterOne.h"//注册验证码
#import "SResetPayPass.h"//重置登录密码
#import "SAccount.h"//三方登录成功后，账号绑定

#import "SRegisterRegisterOne.h"
#import "SRegisterSendVerify.h"

#import "SRegisterLogin.h"

#import "SMessageInfor.h"//服务条款

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import "SRegisterOtherLogin.h"

#import "CustomLayoutConstraint.h"

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"
//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加”-ObjC”
//#import <JPUSHService.h>
#import <AlipaySDK/AlipaySDK.h>
#import "APAuthInfo.h"
#import "APOrderInfo.h"
#import "RSADataSigner.h"

#import "SNPayManager.h"
#import <JPUSHService.h>




@interface SLand ()
{
    BOOL type;//NO登录 YES注册
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeightLayout;
@property (strong, nonatomic) IBOutlet UITextField *iPhoneTF;//注册的时候，备注是：请输入您的手机号
@property (strong, nonatomic) IBOutlet UITextField *passwordTF;
@property (strong, nonatomic) IBOutlet UIView *registerView;//注册View
@property (strong, nonatomic) IBOutlet UIButton *nextBtn;
@property (strong, nonatomic) IBOutlet UILabel *registerTitle;
@property (strong, nonatomic) IBOutlet UIButton * agreeBtn;

@property (strong, nonatomic) IBOutlet UIButton *forGetBtn;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong, nonatomic) IBOutlet UIButton *oneBtn;
@property (strong, nonatomic) IBOutlet UIButton *twoBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *twoBtn_WWW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *twoBtn_W;
@property (strong, nonatomic) IBOutlet UIButton *threeBtn;
@end

@implementation SLand
static NSInteger seq = 0;
- (NSInteger)seq {
    return ++ seq;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    //默认注册
    type = NO;
    _registerView.hidden = YES;
    NSMutableAttributedString * AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"继续注册表示已经阅读并同意 《服务条款》"];
    [AttributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(14, 6)];
    _registerTitle.attributedText = AttributedStr;
    _nextBtn.layer.masksToBounds = YES;
    _nextBtn.layer.cornerRadius = 3;
    [_nextBtn addTarget:self action:@selector(nextBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //忘记密码
    [_forGetBtn addTarget:self action:@selector(forGetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //服务条款
    [_agreeBtn addTarget:self action:@selector(agreeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //登录
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 3;
    [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //微信登录
    [_oneBtn addTarget:self action:@selector(oneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //QQ登录
    [_twoBtn addTarget:self action:@selector(twoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //新浪登录
    [_threeBtn addTarget:self action:@selector(threeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"user_account"] != nil) {
         _iPhoneTF.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_account"];
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"user_password"]!=nil) {
         _passwordTF.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_password"];
    }
   
    if ([WXApi isWXAppInstalled]) {
        NSLog(@"该用户手机安装了微信");
        _oneBtn.hidden = NO;
        
        if ([QQApiInterface isQQInstalled] || [QQApiInterface isTIMSupportApi]) {
            NSLog(@"该用户手机安装了QQ");
            _twoBtn.hidden = NO;
            _twoBtn_W.constant = 100;
        }  else{
            NSLog(@"该用户手机未安装QQ");
            _twoBtn.hidden = YES;
            _twoBtn_W.constant = 0;
        }
    }  else{
        NSLog(@"该用户手机未安装微信");
        _oneBtn.hidden = YES;
        if ([QQApiInterface isQQInstalled] || [QQApiInterface isTIMSupportApi]) {
            NSLog(@"该用户手机安装了QQ");
            _twoBtn.hidden = NO;
            _twoBtn_WWW.constant = -50;
        }  else{
            NSLog(@"该用户手机未安装QQ");
            _twoBtn.hidden = YES;
            _twoBtn_WWW.constant = -100;
        }
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    //判断是否是iphoneX 做顶部距离约束处理
    [CustomLayoutConstraint layoutIphoneXNavTop:_topHeightLayout];
    
}
- (void)createNav {
    
    UIButton * lefthBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    lefthBtn.frame = CGRectMake(0, 0, 44, 50);
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc] initWithCustomView:lefthBtn];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    
    [lefthBtn setImage:[UIImage imageNamed:@"X关闭"] forState:UIControlStateNormal];
    lefthBtn.imageEdgeInsets = UIEdgeInsetsMake(0,  -10, 0, 0);
    
    [lefthBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lefthBtn addTarget:self action:@selector(lefthBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    SLand_nav * nav = [[SLand_nav alloc] initWithFrame:CGRectMake(0, 0, 140, 30)];
    self.navigationItem.titleView = nav;
    [nav.thisSC addTarget:self action:@selector(thisSCClick:) forControlEvents:UIControlEventValueChanged];
}
- (void)lefthBtnClick {
    if (_modalPresent == NO) {
        [self landSuccess];
    } else {
        [self dismissViewControllerAnimated:YES completion:^{
            if (self.SLand_showModel) {
                self.SLand_showModel();
            }
        }];
    }
}
#pragma mark - 服务条款
- (void)agreeBtnClick {
    SMessageInfor * info = [[SMessageInfor alloc] init];
    info.type = @"服务条款";
    [self.navigationController pushViewController:info animated:YES];
}
- (void)thisSCClick:(UISegmentedControl *)sc {
    if (sc.selectedSegmentIndex == 0) {
        //登录
        type = NO;
        _iPhoneTF.placeholder = @"手机号";
        _registerView.hidden = YES;
    } else {
        //注册
        type = YES;
        _registerView.hidden = NO;
        _iPhoneTF.placeholder = @"请输入您的手机号";
    }
}
#pragma mark - 注册
- (void)nextBtnClick {
    if ([_iPhoneTF.text isEqualToString:@""]) {
        [MBProgressHUD showError:@"请输入手机号码" toView:self.view];
        return;
    }
    SRegisterRegisterOne * regOne = [[SRegisterRegisterOne alloc] init];
    regOne.phone = _iPhoneTF.text;
    [regOne sRegisterRegisterOneSuccess:^(NSString *code, NSString *message) {
        if ([code isEqualToString:@"1"]) {
            SRegisterSendVerify * ver = [[SRegisterSendVerify alloc] init];
            ver.phone = _iPhoneTF.text;
            ver.type = @"activate";
            [MBProgressHUD showMessage:nil toView:self.view];
            [ver sRegisterSendVerifySuccess:^(NSString *code, NSString *message) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([code isEqualToString:@"1"]) {
                    SRegisterOne * regOne = [[SRegisterOne alloc] init];
                    regOne.phone = _iPhoneTF.text;
                    [self.navigationController pushViewController:regOne animated:YES];
                } else {
                    [MBProgressHUD showError:message toView:self.view];
                }
            } andFailure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            }];
            
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
}
#pragma mark - 忘记密码
- (void)forGetBtnClick {
    SResetPayPass * pass = [[SResetPayPass alloc] init];
    pass.landddd = self;
    [self.navigationController pushViewController:pass animated:YES];
}
#pragma mark - 登录
- (void)submitBtnClick {
    SRegisterLogin * regLogin = [[SRegisterLogin alloc] init];
    regLogin.phone = _iPhoneTF.text;
    regLogin.password = _passwordTF.text;
    [MBProgressHUD showMessage:nil toView:self.view];
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
            [[NSUserDefaults standardUserDefaults] setObject:_iPhoneTF.text forKey:@"user_account"];
            [[NSUserDefaults standardUserDefaults] setObject:_passwordTF.text forKey:@"user_password"];
            [self sendRidToServer];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

                if (_modalPresent == NO) {
                    [self landSuccess];
                } else {
                    [self dismissViewControllerAnimated:YES completion:^{
                        if (self.SLand_showModel) {
                            self.SLand_showModel();
                        }
                    }];
                }
            });
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}

- (void)sendRidToServer{
  NSString *registrationID = [[NSUserDefaults standardUserDefaults] valueForKey:@"SA_RegistrationID"];
    
    if (SWNOTEmptyStr(registrationID))
    {
//        NSMutableSet * tags = [[NSMutableSet alloc] init];
//        [tags addObjectsFromArray:[NSArray arrayWithObjects:registrationID, nil]];
//            [JPUSHService addTags:tags completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
//            } seq:[self seq]];
        NSMutableDictionary *para = [NSMutableDictionary dictionary];
        [para setValue:registrationID forKey:@"registrationID"];
        [HttpManager postWithUrl:@"User/add_jpush_rid"
                   andParameters:para
                      andSuccess:^(id Json) {
                          NSLog(@"Json = %@",Json);
                      } andFail:^(NSError *error) {
                          NSLog(@"error = %@",[error localizedDescription]);
                      }];
    }
}
#pragma mark - 微信登录
- (void)oneBtnClick {
    [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat];
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
             
             SDWebImageDownloader * downLoad = [SDWebImageDownloader sharedDownloader];
             [downLoad downloadImageWithURL:[NSURL URLWithString:user.rawData[@"headimgurl"]] options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                 NSLog(@"^^%ld",(long)expectedSize);
             } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                 NSLog(@"---[[[0-%@-0]][[[1-%lu-1]]]---",user,(unsigned long)state);
                 NSLog(@"rawData:%@",user.rawData);
                 
                 SRegisterOtherLogin * otherLogin = [[SRegisterOtherLogin alloc] init];
                 otherLogin.openid = user.credential.rawData[@"unionid"];
                 otherLogin.type = @"1";
                 otherLogin.head_pic = image;
                 otherLogin.nickname = user.nickname;
                 [MBProgressHUD showMessage:nil toView:self.view];
                 [otherLogin sRegisterOtherLoginSuccess:^(NSString *code, NSString *message, id data) {
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                     if ([code isEqualToString:@"1"]) {
                         SRegisterOtherLogin * otherLogin = (SRegisterOtherLogin *)data;
                         NSLog(@"otherLogin.data.is_bind_phone:%@",otherLogin.data.is_bind_phone);
                         if ([otherLogin.data.is_bind_phone isEqualToString:@"0"]) {
                             SAccount * account = [[SAccount alloc] init];
                             account.bind_id = otherLogin.data.bind_id;
                             [self.navigationController pushViewController:account animated:YES];
                         } else {
                             [[SRegisterLogin shareInstance] save:otherLogin.data];
                             BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
                             if (!isAutoLogin) {
                                 EMError *error = [[EMClient sharedClient] loginWithUsername:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].easemob_account password:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].easemob_pwd];
                                 if (!error) {
                                     NSLog(@"登录成功");
                                     [[EMClient sharedClient].options setIsAutoLogin:YES];
                                 }
                             }
                             [MBProgressHUD showSuccess:message toView:self.view];
                             [self sendRidToServer];
                             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                 
                                 if (_modalPresent == NO) {
                                     [self landSuccess];
                                 } else {
                                     [self dismissViewControllerAnimated:YES completion:^{
                                         if (self.SLand_showModel) {
                                             self.SLand_showModel();
                                         }
                                     }];
                                 }
                             });
                         }
                     } else {
                         [MBProgressHUD showError:message toView:self.view];
                     }
                 } andFailure:^(NSError *error) {
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                     [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                 }];
             }];
         }
         else
         {
             NSLog(@"%@",error);
             [MBProgressHUD showError:[error localizedDescription] toView:self.view];
         }
    }];
    
}
#pragma mark - QQ授权
- (void)twoBtnClick {
    [ShareSDK cancelAuthorize:SSDKPlatformTypeQQ];

    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
             
             SDWebImageDownloader * downLoad = [SDWebImageDownloader sharedDownloader];
             [downLoad downloadImageWithURL:[NSURL URLWithString:user.rawData[@"figureurl_qq_2"]] options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                 NSLog(@"^^%ld",expectedSize);
             } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                 NSLog(@"---[[[0-%@-0]][[[1-%lu-1]]]---",user,(unsigned long)state);
                 NSLog(@"rawData:%@",user.rawData);
                 
                 SRegisterOtherLogin * otherLogin = [[SRegisterOtherLogin alloc] init];
                 otherLogin.openid = user.uid;
                 otherLogin.type = @"3";
                 otherLogin.head_pic = image;
                 otherLogin.nickname = user.nickname;
                 [MBProgressHUD showMessage:nil toView:self.view];
                 [otherLogin sRegisterOtherLoginSuccess:^(NSString *code, NSString *message, id data) {
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                     if ([code isEqualToString:@"1"]) {
                         SRegisterOtherLogin * otherLogin = (SRegisterOtherLogin *)data;
                         if ([otherLogin.data.is_bind_phone isEqualToString:@"0"]) {
                             SAccount * account = [[SAccount alloc] init];
                             account.bind_id = otherLogin.data.bind_id;
                             [self.navigationController pushViewController:account animated:YES];
                         } else {
                             [[SRegisterLogin shareInstance] save:otherLogin.data];
                             BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
                             if (!isAutoLogin) {
                                 EMError *error = [[EMClient sharedClient] loginWithUsername:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].easemob_account password:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].easemob_pwd];
                                 if (!error) {
                                     NSLog(@"登录成功");
                                     [[EMClient sharedClient].options setIsAutoLogin:YES];
                                 }
                             }
                             [self sendRidToServer];
                             [MBProgressHUD showSuccess:message toView:self.view];
                             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

                                 if (_modalPresent == NO) {
                                     [self landSuccess];
                                 } else {
                                     [self dismissViewControllerAnimated:YES completion:^{
                                         if (self.SLand_showModel) {
                                             self.SLand_showModel();
                                         }
                                     }];
                                 }
                             });
                         }
                     } else {
                         [MBProgressHUD showError:message toView:self.view];
                     }
                 } andFailure:^(NSError *error) {
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                     [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                 }];
             }];
         }
         else
         {
             NSLog(@"%@",error);
             [MBProgressHUD showError:[error localizedDescription] toView:self.view];
         }
     }];
    
}
#pragma mark - 新浪授权
- (void)threeBtnClick {
    [ShareSDK cancelAuthorize:SSDKPlatformTypeSinaWeibo];

    [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
             
             SDWebImageDownloader * downLoad = [SDWebImageDownloader sharedDownloader];
             [downLoad downloadImageWithURL:[NSURL URLWithString:user.rawData[@"headimgurl"]] options:SDWebImageDownloaderLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                 NSLog(@"^^%ld",expectedSize);
             } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                 NSLog(@"---[[[0-%@-0]][[[1-%lu-1]]]---",user,(unsigned long)state);
                 NSLog(@"rawData:%@",user.rawData);
                 
                 SRegisterOtherLogin * otherLogin = [[SRegisterOtherLogin alloc] init];
                 otherLogin.openid = user.uid;
                 otherLogin.type = @"2";
                 otherLogin.head_pic = image;
                 otherLogin.nickname = user.nickname;
                 [MBProgressHUD showMessage:nil toView:self.view];
                 [otherLogin sRegisterOtherLoginSuccess:^(NSString *code, NSString *message, id data) {
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                     if ([code isEqualToString:@"1"]) {
                         SRegisterOtherLogin * otherLogin = (SRegisterOtherLogin *)data;
                         if ([otherLogin.data.is_bind_phone isEqualToString:@"0"]) {
                             SAccount * account = [[SAccount alloc] init];
                             account.bind_id = otherLogin.data.bind_id;
                             [self.navigationController pushViewController:account animated:YES];
                         } else {
                             [[SRegisterLogin shareInstance] save:otherLogin.data];
                             BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
                             if (!isAutoLogin) {
                                 EMError *error = [[EMClient sharedClient] loginWithUsername:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].easemob_account password:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].easemob_pwd];
                                 if (!error) {
                                     NSLog(@"登录成功");
                                     [[EMClient sharedClient].options setIsAutoLogin:YES];
                                 }
                             }
                             [MBProgressHUD showSuccess:message toView:self.view];
                             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                 
                                 if (_modalPresent == NO) {
                                     [self landSuccess];
                                 } else {
                                     [self dismissViewControllerAnimated:YES completion:^{
                                         if (self.SLand_showModel) {
                                             self.SLand_showModel();
                                         }
                                     }];
                                 }
                             });
                         }
                     } else {
                         [MBProgressHUD showError:message toView:self.view];
                     }
                 } andFailure:^(NSError *error) {
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                     [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                 }];
             }];
         }
         else
         {
             NSLog(@"%@",error);
             [MBProgressHUD showError:[error localizedDescription] toView:self.view];
         }
     }];
    
    
}
#pragma mark - 登录成功
- (void)landSuccess {
 
        SNTabBarController * tabBarController = [[SNTabBarController alloc] init];
        self.view.window.rootViewController = tabBarController;
    
}
#pragma 支付宝登录
- (IBAction)doAPAuth:(id)sender {
    
    NSString *authCodeStr= [[NSUserDefaults standardUserDefaults] objectForKey:AUTH_CODE];
    if (authCodeStr.length>0) {
        [self loginInAuthCodeStr:authCodeStr];
    }
    else
    {
    [[SNPayManager sharePayManager] sn_openTheAlipayLogin:^(NSDictionary * dic ) {
        NSLog(@"%@",dic);
        NSString *resu = dic[@"resultStatus"];
        if ([resu intValue]==9000)
        {
        NSString *result = dic[@"result"];
        NSString *authCode = nil;
        if (result.length>0) {
        NSArray *resultArr = [result componentsSeparatedByString:@"&"];
            for (NSString *subResult in resultArr) {
            if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
            authCode = [subResult substringFromIndex:10];
                break;}}
            [[NSUserDefaults standardUserDefaults] setValue:authCode forKey:AUTH_CODE];
            [[NSUserDefaults standardUserDefaults] synchronize];
             [self loginInAuthCodeStr:authCode];
        }
        else
        {
            [MBProgressHUD showError:@"授权失败" toView:self.view];
            
        }
            
        }
        else
            {
                [MBProgressHUD showError:@"授权失败" toView:self.view];
            
            }
    }];
    }
}
-(void)loginInAuthCodeStr:(NSString *)authCode
{
    SRegisterOtherLogin * otherLogin = [[SRegisterOtherLogin alloc] init];
    otherLogin.openid = authCode;
    otherLogin.type = @"7";
    otherLogin.head_pic = nil;
    otherLogin.nickname = @"";
    [MBProgressHUD showMessage:nil toView:self.view];
    [otherLogin sRegisterOtherLoginSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            SRegisterOtherLogin * otherLogin = (SRegisterOtherLogin *)data;
            if ([otherLogin.data.is_bind_phone isEqualToString:@"0"]) {
                SAccount * account = [[SAccount alloc] init];
                account.bind_id = otherLogin.data.bind_id;
                [self.navigationController pushViewController:account animated:YES];
            }
            else {
                
                [[SRegisterLogin shareInstance] save:otherLogin.data];
                BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
                if (!isAutoLogin) {
                    EMError *error = [[EMClient sharedClient] loginWithUsername:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].easemob_account password:[[SRegisterLogin shareInstance] getUserInfo_SuperiorAcme].easemob_pwd];
                    if (!error) {
                        NSLog(@"登录成功");
                        [[EMClient sharedClient].options setIsAutoLogin:YES];
                    }}
                [MBProgressHUD showSuccess:message toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    if (_modalPresent == NO) {
                        [self landSuccess];
                    } else {
                        [self dismissViewControllerAnimated:YES completion:^{
                            if (self.SLand_showModel) {
                                self.SLand_showModel();
                            }
                        }];
                    }
                });
            }
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
    
}


@end
