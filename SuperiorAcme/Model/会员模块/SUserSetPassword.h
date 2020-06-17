//
//  SUserSetPassword.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserSetPasswordSuccessBlock) (NSString * code, NSString * message);
typedef void(^SUserSetPasswordFailureBlock) (NSError * error);

@interface SUserSetPassword : NSObject
@property (nonatomic, copy) NSString * thisNewPassword;//新密码
@property (nonatomic, copy) NSString * rePassword;//确认新密码

- (void)sUserSetPasswordSuccess:(SUserSetPasswordSuccessBlock)success andFailure:(SUserSetPasswordFailureBlock)failure;
@end
