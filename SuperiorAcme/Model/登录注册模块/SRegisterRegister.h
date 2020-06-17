//
//  SRegisterRegister.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/23.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SRegisterRegisterSuccessBlock) (NSString * code, NSString * message);
typedef void(^SRegisterRegisterFailureBlock) (NSError * error);

@interface SRegisterRegister : NSObject
@property (nonatomic, copy) NSString * phone;//注册手机号
@property (nonatomic, copy) NSString * password;//密码 六位数以上
@property (nonatomic, copy) NSString * confirmPassword;//确认密码
@property (nonatomic, copy) NSString * invite_code;//邀请码

- (void)sRegisterRegisterSuccess:(SRegisterRegisterSuccessBlock)success andFailure:(SRegisterRegisterFailureBlock)failure;
@end
