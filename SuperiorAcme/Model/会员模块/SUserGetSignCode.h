//
//  SUserGetSignCode.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserGetSignCodeSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserGetSignCodeFailureBlock) (NSError * error);

@interface SUserGetSignCode : NSObject

@property (nonatomic, strong) SUserGetSignCode * data;
@property (nonatomic, copy) NSString * code;//"注册码"
@property (nonatomic, copy) NSString * head_pic;//用户头像

- (void)sUserGetSignCodeSuccess:(SUserGetSignCodeSuccessBlock)success andFailure:(SUserGetSignCodeFailureBlock)failure;
@end
