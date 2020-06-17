//
//  SRegisterSendVerify.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/23.
//  Copyright © 2017年 GYM. All rights reserved.
//  -1需要登录  0错误 1成功

#import <Foundation/Foundation.h>
typedef void(^SRegisterSendVerifySuccessBlock) (NSString * code, NSString * message);
typedef void(^SRegisterSendVerifyFailureBlock) (NSError * error);

@interface SRegisterSendVerify : NSObject
@property (nonatomic, copy) NSString * phone;//手机号码
@property (nonatomic, copy) NSString * type;//短信类型:注册activate 忘记密码：retrieve 解绑旧手机号：mod_bind 绑定新手机号：re_bind (三方登录绑定) 重置支付密码：re_pay_pwd

- (void)sRegisterSendVerifySuccess:(SRegisterSendVerifySuccessBlock)success andFailure:(SRegisterSendVerifyFailureBlock)failure;
@end
