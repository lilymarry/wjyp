//
//  SRegisterCheckVerify.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/23.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SRegisterCheckVerifySuccessBlock) (NSString * code, NSString * message);
typedef void(^SRegisterCheckVerifyFailureBlock) (NSError * error);

@interface SRegisterCheckVerify : NSObject
@property (nonatomic, copy) NSString * phone;//手机号
@property (nonatomic, copy) NSString * type;//短信类型:注册activate 忘记密码：retrieve 解绑旧手机号：mod_bind 绑定新手机号：re_bind 重置支付密码：re_pay_pwd
@property (nonatomic, copy) NSString * verify;//验证码

- (void)sRegisterCheckVerifySuccess:(SRegisterCheckVerifySuccessBlock)success andFailure:(SRegisterCheckVerifyFailureBlock)failure;
@end
