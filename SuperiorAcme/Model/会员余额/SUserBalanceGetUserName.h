//
//  SUserBalanceGetUserName.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserBalanceGetUserNameSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserBalanceGetUserNameFailureBlock) (NSError * error);

@interface SUserBalanceGetUserName : NSObject
@property (nonatomic, copy) NSString * code;//会员id或者手机号

@property (nonatomic, strong) SUserBalanceGetUserName * data;
@property (nonatomic, copy) NSString * real_name;//"真实姓名"

- (void)sUserBalanceGetUserNameSuccess:(SUserBalanceGetUserNameSuccessBlock)success andFailure:(SUserBalanceGetUserNameFailureBlock)failure;
@end
