//
//  SUserChangePhone.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserChangePhoneSuccessBlock) (NSString * code, NSString * message);
typedef void(^SUserChangePhoneFailureBlock) (NSError * error);

@interface SUserChangePhone : NSObject
@property (nonatomic, copy) NSString * thisNewPhone;//新手机号
@property (nonatomic, copy) NSString * verify;//验证码

- (void)sUserChangePhoneSuccess:(SUserChangePhoneSuccessBlock)success andFailure:(SUserChangePhoneFailureBlock)failure;
@end
