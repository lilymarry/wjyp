//
//  SUserVerificationPayPwd.h
//  SuperiorAcme
//
//  Created by GYM on 2018/2/9.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserVerificationPayPwdSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserVerificationPayPwdFailureBlock) (NSError * error);

//接口特殊情况：code 0代表验证失败，1代表验证成功

@interface SUserVerificationPayPwd : NSObject
@property (nonatomic, copy) NSString * PayPwd;//    支付密码

@property (nonatomic, strong) SUserVerificationPayPwd * data;
@property (nonatomic, copy) NSString * status;//": 1           // 0->未设置密码，1->已设置

- (void)sUserVerificationPayPwdSuccess:(SUserVerificationPayPwdSuccessBlock)success andFailure:(SUserVerificationPayPwdFailureBlock)failure;
@end
