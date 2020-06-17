//
//  SUserResetPayPwd.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserResetPayPwdSuccessBlock) (NSString * code, NSString * message);
typedef void(^SUserResetPayPwdFailureBlock) (NSError * error);

@interface SUserResetPayPwd : NSObject
@property (nonatomic, copy) NSString * phone;//手机号
@property (nonatomic, copy) NSString * verify;//验证码 验证码标识 type=re_pay_pwd
@property (nonatomic, copy) NSString * thisNewPayPwd;//新密码
@property (nonatomic, copy) NSString * rePayPwd;//确认密码

- (void)sUserResetPayPwdSuccess:(SUserResetPayPwdSuccessBlock)success andFailure:(SUserResetPayPwdFailureBlock)failure;
@end
