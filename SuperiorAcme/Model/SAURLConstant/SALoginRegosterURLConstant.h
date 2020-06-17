//
//  SALoginRegosterURLConstant.h
//  SuperiorAcme
//
//  Created by fxg on 2018/7/6.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SAMineURLConstant.h"
#import "SAOnLineMallURLConstant.h"

@interface SALoginRegosterURLConstant : NSObject

#pragma mark - 发送短信验证码
extern NSString *const SRegisterSendVerify_Url;

#pragma mark - 注册第一步
extern NSString *const SRegisterRegisterOne_Url;

#pragma mark - 验证短信验证码
extern NSString *const SRegisterCheckVerify_Url;

#pragma mark - 用户注册
extern NSString *const SRegisterRegister_Url;

#pragma mark - 用户登录
extern NSString *const SRegisterLogin_Url;

#pragma mark - 忘记密码
extern NSString *const SRegisterResetPassword_Url;

#pragma mark - 三方登录
extern NSString *const SRegisterOtherLogin_Url;

#pragma mark - 三方登录绑定手机
extern NSString *const SRegisterOtherLoginBind_Url;

#pragma mark - 扫码登录
extern NSString *const ScanQRCodeLogin_url;

@end
