//
//  SRegisterResetPassword.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/23.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SRegisterResetPasswordSuccessBlock) (NSString * code, NSString * message);
typedef void(^SRegisterResetPasswordFailureBlock) (NSError * error);

@interface SRegisterResetPassword : NSObject
@property (nonatomic, copy) NSString * phone;//用户手机号
@property (nonatomic, copy) NSString * thisNewPassword;//新密码
@property (nonatomic, copy) NSString * confirmPassword;//确认密码
@property (nonatomic, copy) NSString * verify;//验证码

- (void)sRegisterResetPasswordSuccess:(SRegisterResetPasswordSuccessBlock)success andFailure:(SRegisterResetPasswordFailureBlock)failure;
@end
