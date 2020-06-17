//
//  User.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/23.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (nonatomic, copy) NSString * user_id;//"用户ID",
@property (nonatomic, copy) NSString * phone;//"手机号",
@property (nonatomic, copy) NSString * easemob_account;//环信账号,
@property (nonatomic, copy) NSString * easemob_pwd;//环信密码,
@property (nonatomic, copy) NSString * balance;//"余额",
@property (nonatomic, copy) NSString * auth_status;//"认证状态", //0未认证 1.认证中 2.已认证
@property (nonatomic, copy) NSString * head_pic;//"头像",
@property (nonatomic, copy) NSString * nickname;//"昵称",
@property (nonatomic, copy) NSString * integral;//"积分",
@property (nonatomic, copy) NSString * ticket_num;//购物券数量,
@property (nonatomic, copy) NSString * token;//"token"
@property (nonatomic, copy) NSString * expired_time;//过期时间,
//@property (nonatomic, copy) NSString * new_msg;//未读消息
@property (nonatomic, copy) NSString * server_line;//"客服电话"

@property (nonatomic, strong) User * point;
@property (nonatomic, copy) NSString * date;//"日期",
@property (nonatomic, copy) NSString * point_num;//"无界指数"
@property (nonatomic, copy) NSString * is_bind_phone;//"是否绑定手机号", //0否 1是
@property (nonatomic, copy) NSString * bind_id;//绑定id

@property (nonatomic, copy) NSString * invite_code; //邀请码
@end
