//
//  SRegisterOtherLogin.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/23.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
typedef void(^SRegisterOtherLoginSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SRegisterOtherLoginFailureBlock) (NSError * error);

@interface SRegisterOtherLogin : NSObject
@property (nonatomic, copy) NSString * openid;//授权登陆后给的openid : 微信传unionId ，QQ和新浪微博传userId 或者 alipay的auth_code
@property (nonatomic, copy) NSString * type;//登录类型 1 微信 2微博 3 QQ ,7 支付宝
@property (nonatomic, strong) UIImage * head_pic;//头像
@property (nonatomic, copy) NSString * nickname;//昵称

////如果code返回0，表示未绑定手机号
//@property (nonatomic, strong) SRegisterOtherLogin * data;
//

//如果code返回1，表示已绑定手机号
@property (nonatomic, strong) User * data;

- (void)sRegisterOtherLoginSuccess:(SRegisterOtherLoginSuccessBlock)success andFailure:(SRegisterOtherLoginFailureBlock)failure;

+ (id)shareInstance;
//保存登陆用户信息
- (void)save:(User *)userInfo;
//获取已保存用户信息
- (User *)getUserInfo_SuperiorAcme;
//删除用户信息
- (void)deleteUserInfo;
@end
