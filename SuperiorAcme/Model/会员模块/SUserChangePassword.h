//
//  SUserChangePassword.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserChangePasswordSuccessBlock) (NSString * code, NSString * message);
typedef void(^SUserChangePasswordFailureBlock) (NSError * error);

@interface SUserChangePassword : NSObject
@property (nonatomic, copy) NSString * oldPassword;//旧密码
@property (nonatomic, copy) NSString * thisNewPassword;//新密码
@property (nonatomic, copy) NSString * rePassword;//确认密码

- (void)sUserChangePasswordSuccess:(SUserChangePasswordSuccessBlock)success andFailure:(SUserChangePasswordFailureBlock)failure;
@end
