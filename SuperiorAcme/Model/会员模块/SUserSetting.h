//
//  SUserSetting.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserSettingSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserSettingFailureBlock) (NSError * error);

@interface SUserSetting : NSObject

//需要传入用户token

@property (nonatomic, strong) SUserSetting * data;
@property (nonatomic, copy) NSString * user_id;//"会员ID",
@property (nonatomic, copy) NSString * auth_status;//"0", //认证状态 0 未认证 1认证中 2 已认证
@property (nonatomic, copy) NSString * phone;//"绑定手机"
@property (nonatomic, copy) NSString * is_password;//‘0 无登录密码 1有登录密码’
@property (nonatomic, copy) NSString * is_pay_password;//‘0 无支付密码 1有支付密码’

@property (nonatomic, strong) SUserSetting * qq_bind;//qq绑定
@property (nonatomic, strong) SUserSetting * wx_bind;//微信绑定
@property (nonatomic, strong) SUserSetting * weibo_bind;///微博绑定
@property (nonatomic, strong) SUserSetting * alipay_bind;///支付宝绑定
@property (nonatomic, copy) NSString * is_bind;//是否绑定 0 未绑定 1已绑定
@property (nonatomic, strong) SUserSetting * bind_info;
@property (nonatomic, copy) NSString * bind_id;//": "24",  //绑定id (暂时没用到)
@property (nonatomic, copy) NSString * nickname;//": "吃瓜群众甲" //昵称

- (void)sUserSettingSuccess:(SUserSettingSuccessBlock)success andFailure:(SUserSettingFailureBlock)failure;
@end
