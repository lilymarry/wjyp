//
//  SRegisterOtherLoginBind.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/23.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

typedef void(^SRegisterOtherLoginBindSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SRegisterOtherLoginBindFailureBlock) (NSError * error);

@interface SRegisterOtherLoginBind : NSObject
@property (nonatomic, copy) NSString * bind_id;//绑定id
@property (nonatomic, copy) NSString * phone;//绑定手机号
@property (nonatomic, copy) NSString * verify;//验证码
@property (nonatomic, copy) NSString * invite_code;//邀请码

@property (nonatomic, strong) User * data;

- (void)sRegisterOtherLoginBindSuccess:(SRegisterOtherLoginBindSuccessBlock)success andFailure:(SRegisterOtherLoginBindFailureBlock)failure;
@end
