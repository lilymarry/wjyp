//
//  SALoginRegosterURLConstant.m
//  SuperiorAcme
//
//  Created by fxg on 2018/7/6.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SALoginRegosterURLConstant.h"

@implementation SALoginRegosterURLConstant

#pragma mark - 发送短信验证码
NSString *const SRegisterSendVerify_Url = @"Register/sendVerify";

#pragma mark - 注册第一步
NSString *const SRegisterRegisterOne_Url = @"Register/registerOne";

#pragma mark - 验证短信验证码
NSString *const SRegisterCheckVerify_Url = @"Register/checkVerify";

#pragma mark - 用户注册
NSString *const SRegisterRegister_Url = @"Register/register";

#pragma mark - 用户登录
 NSString *const SRegisterLogin_Url = @"Register/login";

#pragma mark - 忘记密码
 NSString *const SRegisterResetPassword_Url = @"Register/resetPassword";

#pragma mark - 三方登录
 NSString *const SRegisterOtherLogin_Url = @"Register/otherLogin";

#pragma mark - 三方登录绑定手机
 NSString *const SRegisterOtherLoginBind_Url = @"Register/otherLoginBind";

#pragma mark - 扫码登录
 NSString *const ScanQRCodeLogin_url = @"Register/qr_login";

@end
