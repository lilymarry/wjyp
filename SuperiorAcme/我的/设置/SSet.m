//
//  SSet.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/21.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SSet.h"
#import "SPersonalData.h"//修改个人资料
#import "SRealNameAuth.h"//实名认证
#import "SRechargeBank.h"//我的银行卡
#import "SModifyLoginPassword.h"//修改登录密码
#import "SChangeiPhone.h"//换绑手机
#import "SLand.h"//登录

#import "SUserSetting.h"
#import "SUserBindOther.h"//绑定三方
#import "SUserRemoveBind.h"//解绑三方
#import <ShareSDK/ShareSDK.h>
#import "SUserUserInfo.h"//是否完善资料
#import "SNPayManager.h"
@interface SSet ()
{
    BOOL three_type;//登录密码是否设置
    BOOL four_type;//支付密码是否设置
    BOOL five_type;//手机是否绑定
    NSString * iPhone;//换绑手机号
    
    BOOL bindOne_type;//微信绑定
    BOOL bindTwo_type;//qq绑定
    BOOL bindThree_type;//新浪绑定
    BOOL bindFour_type;//新浪绑定
}
@property (strong, nonatomic) IBOutlet UIButton *oneBtn;//个人资料
@property (strong, nonatomic) IBOutlet UIButton *twoBtn;//实名认证
@property (strong, nonatomic) IBOutlet UIButton *threeBtn;//修改登录密码
@property (strong, nonatomic) IBOutlet UILabel *three_Title;
@property (strong, nonatomic) IBOutlet UIButton *fourBtn;//修改支付密码
@property (strong, nonatomic) IBOutlet UILabel *fourTitle;
@property (strong, nonatomic) IBOutlet UIButton *fiveBtn;//换绑手机
@property (strong, nonatomic) IBOutlet UILabel *five_iPhone;
@property (strong, nonatomic) IBOutlet UILabel *sexContent;
@property (strong, nonatomic) IBOutlet UIButton *sexBtn;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;

@property (strong, nonatomic) IBOutlet UILabel *bindOneTitle;
@property (strong, nonatomic) IBOutlet UIButton *bindOneBtn;
@property (strong, nonatomic) IBOutlet UILabel *bindTwoTitle;
@property (strong, nonatomic) IBOutlet UIButton *bindTwoBtn;
@property (strong, nonatomic) IBOutlet UILabel *bindThreeTitle;
@property (strong, nonatomic) IBOutlet UIButton *bindThreeBtn;

@property (strong, nonatomic) IBOutlet UILabel *bindFourTitle;
@property (strong, nonatomic) IBOutlet UIButton *bindFourBtn;

@end

@implementation SSet

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self createNav];
    
    
    _sexContent.text = [NSString stringWithFormat:@"%.2fMB",[self folderFileSizeAtPath]];
    [_oneBtn addTarget:self action:@selector(oneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_twoBtn addTarget:self action:@selector(twoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_threeBtn addTarget:self action:@selector(threeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_fourBtn addTarget:self action:@selector(fourBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_fiveBtn addTarget:self action:@selector(fiveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [_sexBtn addTarget:self action:@selector(sexBtnClick) forControlEvents:UIControlEventTouchUpInside];
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 3;
    [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    //微信
    [_bindOneBtn addTarget:self action:@selector(bindOneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //QQ
    [_bindTwoBtn addTarget:self action:@selector(bindTwoBtnClick) forControlEvents:UIControlEventTouchUpInside];
    //新浪
    [_bindThreeBtn addTarget:self action:@selector(bindThreeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [_bindFourBtn addTarget:self action:@selector(bindFourBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor whiteColor]];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;//设置系统时间颜色为亮白
    
    self.title = @"设置";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:17],
       NSForegroundColorAttributeName:[UIColor blackColor]}];
    
}
- (void)viewDidAppear:(BOOL)animated {
    SUserSetting * set = [[SUserSetting alloc] init];
    [MBProgressHUD showMessage:nil toView:self.view];
    [set sUserSettingSuccess:^(NSString *code, NSString *message, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            SUserSetting * set = (SUserSetting *)data;
            _five_iPhone.text = set.data.phone;
            iPhone = set.data.phone;
            if ([set.data.phone isEqualToString:@""]) {
                five_type = NO;
            } else {
                five_type = YES;
            }
            if ([set.data.is_password integerValue] == 0) {
                _three_Title.text = @"设置登录密码";
                three_type = NO;
            } else {
                _three_Title.text = @"修改登录密码";
                three_type = YES;
            }
            if ([set.data.is_pay_password integerValue] == 0) {
                _fourTitle.text = @"设置支付密码";
                four_type = NO;
            } else {
                _fourTitle.text = @"修改支付密码";
                four_type = YES;
            }
            if ([set.data.wx_bind.is_bind integerValue] == 0) {
                _bindOneTitle.text = @"未绑定";
                _bindOneTitle.textColor = [UIColor redColor];
                bindOne_type = NO;
            } else {
                _bindOneTitle.text = set.data.wx_bind.bind_info.nickname;
                _bindOneTitle.textColor = WordColor_sub;
                bindOne_type = YES;
            }
            if ([set.data.qq_bind.is_bind integerValue] == 0) {
                _bindTwoTitle.text = @"未绑定";
                _bindTwoTitle.textColor = [UIColor redColor];
                bindTwo_type = NO;
            } else {
                _bindTwoTitle.text = set.data.qq_bind.bind_info.nickname;
                _bindTwoTitle.textColor = WordColor_sub;
                bindTwo_type = YES;
            }
            if ([set.data.weibo_bind.is_bind integerValue] == 0) {
                _bindThreeTitle.text = @"未绑定";
                _bindThreeTitle.textColor = [UIColor redColor];
                bindThree_type = NO;
            } else {
                _bindThreeTitle.text = set.data.weibo_bind.bind_info.nickname;
                _bindThreeTitle.textColor = WordColor_sub;
                bindThree_type = YES;
            }
            if ([set.data.alipay_bind.is_bind integerValue] == 0) {
                _bindFourTitle.text = @"未绑定";
                _bindFourTitle.textColor = [UIColor redColor];
                bindFour_type = NO;
            } else {
                _bindFourTitle.text = set.data.alipay_bind.bind_info.nickname;
                _bindFourTitle.textColor = WordColor_sub;
                bindFour_type = YES;
            }
            
        } else {
            [MBProgressHUD showError:message toView:self.view];
        }
    } andFailure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
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

#pragma mark - 个人资料
- (void)oneBtnClick {
    SPersonalData * pd = [[SPersonalData alloc] init];
    [self.navigationController pushViewController:pd animated:YES];
}
#pragma mark - 实名认证
- (void)twoBtnClick {
    SUserUserInfo * userInfo = [[SUserUserInfo alloc] init];
    [userInfo sUserUserInfoSuccess:^(NSString *code, NSString *message, id data) {
        SUserUserInfo * userInfo = (SUserUserInfo *)data;
        if ([userInfo.data.personal_data_status integerValue] == 0) {
            [MBProgressHUD showError:@"请先完善个人资料" toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                SPersonalData * pd = [[SPersonalData alloc] init];
                [self.navigationController pushViewController:pd animated:YES];
            });
        } else {
            SRealNameAuth * auth = [[SRealNameAuth alloc] init];
            [self.navigationController pushViewController:auth animated:YES];
        }
    } andFailure:^(NSError *error) {
    }];
}
#pragma mark - 我的银行卡
- (IBAction)bankBtn:(UIButton *)sender {
    SUserUserInfo * userInfo = [[SUserUserInfo alloc] init];
    [userInfo sUserUserInfoSuccess:^(NSString *code, NSString *message, id data) {
        SUserUserInfo * userInfo = (SUserUserInfo *)data;
        if ([userInfo.data.personal_data_status integerValue] == 0) {
            [MBProgressHUD showError:@"请先完善个人资料" toView:self.view];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                SPersonalData * pd = [[SPersonalData alloc] init];
                [self.navigationController pushViewController:pd animated:YES];
            });
        } else {
            if ([userInfo.data.auth_status integerValue] == 1){
                [MBProgressHUD showError:@"实名认证中,请耐心等待..." toView:self.view];
            }else if ([userInfo.data.auth_status integerValue] != 2) {
                [MBProgressHUD showError:@"请先完善个人认证" toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    SRealNameAuth * auth = [[SRealNameAuth alloc] init];
                    [self.navigationController pushViewController:auth animated:YES];
                });
            } else {
                SRechargeBank * bank = [[SRechargeBank alloc] init];
                [self.navigationController pushViewController:bank animated:YES];

            }
        }
    } andFailure:^(NSError *error) {
    }];
}
#pragma mark - 修改登录密码
- (void)threeBtnClick {
    SModifyLoginPassword * logPass = [[SModifyLoginPassword alloc] init];
    logPass.set_type = three_type;
    [self.navigationController pushViewController:logPass animated:YES];
}
#pragma mark - 修改支付密码
- (void)fourBtnClick {
    SModifyLoginPassword * logPass = [[SModifyLoginPassword alloc] init];
    logPass.set_type = four_type;
    logPass.type = YES;
    logPass.setttt = self;
    /*
     *获取绑定的手机号
     */
    logPass.iPhone = iPhone;
    [self.navigationController pushViewController:logPass animated:YES];
}
#pragma mark - 换绑手机
- (void)fiveBtnClick {
    SChangeiPhone * change = [[SChangeiPhone alloc] init];
    change.typeBind = five_type;
    change.iPhone = iPhone;
    [self.navigationController pushViewController:change animated:YES];
}
#pragma mark - 微信
- (void)bindOneBtnClick {
    if (bindOne_type == NO) {
        [ShareSDK getUserInfo:SSDKPlatformTypeWechat
               onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
         {
             if (state == SSDKResponseStateSuccess)
             {
                 
                 NSLog(@"uid=%@",user.uid);
                 NSLog(@"%@",user.credential);
                 NSLog(@"token=%@",user.credential.token);
                 NSLog(@"nickname=%@",user.nickname);
                 
                 SUserBindOther * otherLogin = [[SUserBindOther alloc] init];
                 otherLogin.openid = user.credential.rawData[@"unionid"];
                 otherLogin.type = @"1";
                 otherLogin.nickname = user.nickname;
                 [MBProgressHUD showMessage:nil toView:self.view];
                 [otherLogin sUserBindOtherSuccess:^(NSString *code, NSString *message) {
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                     if ([code isEqualToString:@"1"]) {
                         [MBProgressHUD showSuccess:message toView:self.view];
                         [self viewDidAppear:YES];
                     } else {
                         [MBProgressHUD showError:message toView:self.view];
                     }
                 } andFailure:^(NSError *error) {
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                     [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                 }];
             }
             else
             {
                 NSLog(@"%@",error);
                 [MBProgressHUD showError:[error localizedDescription] toView:self.view];
             }
         }];
    } else {
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"取消微信绑定?" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat];
            SUserRemoveBind * remove = [[SUserRemoveBind alloc] init];
            remove.type = @"1";
            [MBProgressHUD showMessage:nil toView:self.view];
            [remove sUserRemoveBindSuccess:^(NSString *code, NSString *message) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([code isEqualToString:@"1"]) {
                    [MBProgressHUD showSuccess:message toView:self.view];
                    [self viewDidAppear:YES];
                } else {
                    [MBProgressHUD showError:message toView:self.view];
                }
            } andFailure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            }];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
#pragma mark - QQ
- (void)bindTwoBtnClick {
    if (bindTwo_type == NO) {
        [ShareSDK getUserInfo:SSDKPlatformTypeQQ
               onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
         {
             if (state == SSDKResponseStateSuccess)
             {
                 
                 NSLog(@"uid=%@",user.uid);
                 NSLog(@"%@",user.credential);
                 NSLog(@"token=%@",user.credential.token);
                 NSLog(@"nickname=%@",user.nickname);
                 
                 SUserBindOther * otherLogin = [[SUserBindOther alloc] init];
                 otherLogin.openid = user.uid;
                 otherLogin.type = @"3";
                 otherLogin.nickname = user.nickname;
                 [MBProgressHUD showMessage:nil toView:self.view];
                 [otherLogin sUserBindOtherSuccess:^(NSString *code, NSString *message) {
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                     if ([code isEqualToString:@"1"]) {
                         [MBProgressHUD showSuccess:message toView:self.view];
                         [self viewDidAppear:YES];
                     } else {
                         [MBProgressHUD showError:message toView:self.view];
                     }
                 } andFailure:^(NSError *error) {
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                     [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                 }];
             }
             else
             {
                 NSLog(@"%@",error);
                 [MBProgressHUD showError:[error localizedDescription] toView:self.view];
             }
         }];
    } else {
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"取消QQ绑定?" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [ShareSDK cancelAuthorize:SSDKPlatformTypeQQ];
            SUserRemoveBind * remove = [[SUserRemoveBind alloc] init];
            remove.type = @"3";
            [MBProgressHUD showMessage:nil toView:self.view];
            [remove sUserRemoveBindSuccess:^(NSString *code, NSString *message) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([code isEqualToString:@"1"]) {
                    [MBProgressHUD showSuccess:message toView:self.view];
                    [self viewDidAppear:YES];
                } else {
                    [MBProgressHUD showError:message toView:self.view];
                }
            } andFailure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            }];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
#pragma mark - 新浪
- (void)bindThreeBtnClick {
    if (bindThree_type == NO) {
        [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo
               onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
         {
             if (state == SSDKResponseStateSuccess)
             {
                 
                 NSLog(@"uid=%@",user.uid);
                 NSLog(@"%@",user.credential);
                 NSLog(@"token=%@",user.credential.token);
                 NSLog(@"nickname=%@",user.nickname);
                 
                 SUserBindOther * otherLogin = [[SUserBindOther alloc] init];
                 otherLogin.openid = user.uid;
                 otherLogin.type = @"2";
                 otherLogin.nickname = user.nickname;
                 [MBProgressHUD showMessage:nil toView:self.view];
                 [otherLogin sUserBindOtherSuccess:^(NSString *code, NSString *message) {
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                     if ([code isEqualToString:@"1"]) {
                         [MBProgressHUD showSuccess:message toView:self.view];
                         [self viewDidAppear:YES];
                     } else {
                         [MBProgressHUD showError:message toView:self.view];
                     }
                 } andFailure:^(NSError *error) {
                     [MBProgressHUD hideHUDForView:self.view animated:YES];
                     [MBProgressHUD showError:[error localizedDescription] toView:self.view];
                 }];
             }
             else
             {
                 NSLog(@"%@",error);
                 [MBProgressHUD showError:[error localizedDescription] toView:self.view];
             }
         }];
    } else {
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"取消新浪绑定?" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [ShareSDK cancelAuthorize:SSDKPlatformTypeSinaWeibo];
            SUserRemoveBind * remove = [[SUserRemoveBind alloc] init];
            remove.type = @"2";
            [MBProgressHUD showMessage:nil toView:self.view];
            [remove sUserRemoveBindSuccess:^(NSString *code, NSString *message) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([code isEqualToString:@"1"]) {
                    [MBProgressHUD showSuccess:message toView:self.view];
                    [self viewDidAppear:YES];
                } else {
                    [MBProgressHUD showError:message toView:self.view];
                }
            } andFailure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            }];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
- (void)bindFourBtnClick
{
    if (bindFour_type==NO) {
        
    NSString *authCodeStr= [[NSUserDefaults standardUserDefaults] objectForKey:AUTH_CODE];
        if (authCodeStr.length>0) {
            [self BlindInAuthCodeStr:authCodeStr];
        }
        else
        {
       
    [[SNPayManager sharePayManager] sn_openTheAlipayLogin:^(NSDictionary * dic ) {
        NSLog(@"SSS%@",dic);
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
                        break;}}}
            if (authCode.length>0) {
                [[NSUserDefaults standardUserDefaults] setValue:authCode forKey:AUTH_CODE];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self BlindInAuthCodeStr:authCode];
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
        }}
    else
    {
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"取消支付宝绑定?" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         //   [ShareSDK cancelAuthorize:SSDKPlatformTypeSinaWeibo];
            SUserRemoveBind * remove = [[SUserRemoveBind alloc] init];
            remove.type = @"7";
            [MBProgressHUD showMessage:nil toView:self.view];
            [remove sUserRemoveBindSuccess:^(NSString *code, NSString *message) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([code isEqualToString:@"1"]) {
                    [MBProgressHUD showSuccess:message toView:self.view];
                    [self viewDidAppear:YES];
                    [[NSUserDefaults standardUserDefaults] removeObjectForKey:AUTH_CODE];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                } else {
                    [MBProgressHUD showError:message toView:self.view];
                }
            } andFailure:^(NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                [MBProgressHUD showError:[error localizedDescription] toView:self.view];
            }];
        }]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
-(void)BlindInAuthCodeStr:(NSString *)authCode
{
    SUserBindOther * otherLogin = [[SUserBindOther alloc] init];
    otherLogin.auth_code = authCode;
    [MBProgressHUD showMessage:nil toView:self.view];
    [otherLogin sUserBindOtherAlipay_infoSuccess:^(NSString *code, NSString *message,NSDictionary *dic) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if ([code isEqualToString:@"1"]) {
            SUserBindOther * otherLogin = [[SUserBindOther alloc] init];
            NSString *open_id=dic[@"open_id"];
            if (open_id.length>0) {
                otherLogin.openid = dic[@"open_id"];
            }
            else
            {
                otherLogin.openid =authCode;
            }
            otherLogin.type = @"7";
            otherLogin.nickname = @"";
            [MBProgressHUD showMessage:nil toView:self.view];
            [otherLogin sUserBindOtherSuccess:^(NSString *code, NSString *message) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if ([code isEqualToString:@"1"]) {
                    [MBProgressHUD showSuccess:message toView:self.view];
                    [self viewDidAppear:YES];
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
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [MBProgressHUD showError:[error localizedDescription] toView:self.view];
    }];
}
    
    

#pragma mark - 清理缓存
- (void)sexBtnClick {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"缓存大小为%.2fMB，是否清理？",[self folderFileSizeAtPath]] preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击确定");
        //开始清理
        [self clearCacheResult:^(BOOL result) {
            NSString * huancun = [NSString stringWithFormat:@"%.2f",[self folderFileSizeAtPath]];
            if (huancun.doubleValue ==0.00) {
                _sexContent.text = @"0MB";
            } else {
                _sexContent.text = [NSString stringWithFormat:@"%.2fMB",[self folderFileSizeAtPath]];
            }
        }];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark -清除缓存
//单个文件
- (CGFloat)sigleFileSizeAtPath:(NSString *)path {
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        return [fileManager attributesOfItemAtPath:path error:nil].fileSize/1024.f/1024.f;
    }
    return 0.f;
}
//计算全部
- (CGFloat)folderFileSizeAtPath {
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSString * path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    CGFloat folderSize = 0.f;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray * childerFiles = [fileManager subpathsAtPath:path];
        for (NSString * fileName in childerFiles) {
            NSString * absolutePath = [path stringByAppendingPathComponent:fileName];
            folderSize += [self sigleFileSizeAtPath:absolutePath];
        }
        folderSize = folderSize + [[SDImageCache sharedImageCache]getSize]/1024.f/1024.f;
        return folderSize;
    }
    return 0.f;
}

//清除
- (void)clearCacheResult:(void(^)(BOOL result))resultBlock {
    
    NSString * path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        resultBlock(YES);
    }];
}
#pragma mark - 退出登录
- (void)submitBtnClick {
    //退出登录，清空用户信息
    [[SRegisterLogin shareInstance] deleteUserInfo];
    EMError *error = [[EMClient sharedClient] logout:YES];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_password"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    if (!error) {
        NSLog(@"退出成功");
    }
    SLand * land = [[SLand alloc] init];
    UINavigationController * landNav = [[UINavigationController alloc] initWithRootViewController:land];
    self.view.window.rootViewController = landNav;
}
@end
