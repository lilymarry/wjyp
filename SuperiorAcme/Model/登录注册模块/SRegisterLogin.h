//
//  SRegisterLogin.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/23.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
typedef void(^SRegisterLoginSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SRegisterLoginFailureBlock) (NSError * error);

@interface SRegisterLogin : NSObject
@property (nonatomic, copy) NSString * phone;//登录手机号
@property (nonatomic, copy) NSString * password;//登录密码
@property (nonatomic, copy) NSString * method;
@property (nonatomic, strong) User * data;

- (void)sRegisterLoginSuccess:(SRegisterLoginSuccessBlock)success andFailure:(SRegisterLoginFailureBlock)failure;

+ (instancetype)shareInstance;
//保存登陆用户信息
- (void)save:(User *)userInfo;
//获取已保存用户信息
- (User *)getUserInfo_SuperiorAcme;
//删除用户信息
- (void)deleteUserInfo;

#pragma mark - 获取邀请码
+(NSString *)shareInviteCode;

//追加邀请码字符串
+(NSString *)shareAppendInviteCode;

@end
