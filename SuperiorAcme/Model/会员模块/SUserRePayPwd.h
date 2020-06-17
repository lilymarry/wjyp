//
//  SUserRePayPwd.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserRePayPwdSuccessBlock) (NSString * code, NSString * message);
typedef void(^SUserRePayPwdFailureBlock) (NSError * error);

@interface SUserRePayPwd : NSObject
@property (nonatomic, copy) NSString * oldPayPwd;//原支付密码
@property (nonatomic, copy) NSString * thisNewPayPwd;//新支付密码
@property (nonatomic, copy) NSString * rePayPwd;//确认密码

- (void)sUserRePayPwdSuccess:(SUserRePayPwdSuccessBlock)success andFailure:(SUserRePayPwdFailureBlock)failure;
@end
