//
//  SUserSetPayPwd.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserSetPayPwdSuccessBlock) (NSString * code, NSString * message);
typedef void(^SUserSetPayPwdFailureBlock) (NSError * error);

@interface SUserSetPayPwd : NSObject
@property (nonatomic, copy) NSString * thisNewPayPwd;//密码
@property (nonatomic, copy) NSString * rePayPwd;//确认密码

- (void)sUserSetPayPwdSuccess:(SUserSetPayPwdSuccessBlock)success andFailure:(SUserSetPayPwdFailureBlock)failure;
@end
