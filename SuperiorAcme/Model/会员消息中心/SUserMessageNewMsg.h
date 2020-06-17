//
//  SUserMessageNewMsg.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserMessageNewMsgSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^sendMessageNewMsgSuccess) (NSString * code, NSString * message);
typedef void(^SUserMessageNewMsgFailureBlock) (NSError * error);

@interface SUserMessageNewMsg : NSObject
@property (nonatomic, copy) NSString * account_json;//json 字符串 [{"easemob_account":"环信账号","msg_count":"消息数","last_content":"一条内容","last_time":"时间"}]
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, strong) SUserMessageNewMsg * data;
@property (nonatomic, copy) NSString * msg_title;//": "系统通知消息标题",
@property (nonatomic, copy) NSString * msg_time;//": "系统通知消息时间",
@property (nonatomic, copy) NSString * msg_count;//": "系统消息未读",
@property (nonatomic, copy) NSString * announce_title;//": "公告标题",
@property (nonatomic, copy) NSString * announce_time;//": "公告时间",
@property (nonatomic, copy) NSString * announce_count;//": "未读公告数",
@property (nonatomic, copy) NSString * order_title;//": "订单内容",
@property (nonatomic, copy) NSString * order_time;//": "订单消息",
@property (nonatomic, copy) NSString * order_count;//": "订单消息数",
//聊天列表
@property (nonatomic, copy) NSArray * chat_list;
@property (nonatomic, copy) NSString * nickname;//": "昵称",
@property (nonatomic, copy) NSString * head_pic;//": "头像",
@property (nonatomic, copy) NSString * user_id;//": "会员id",
@property (nonatomic, copy) NSString * easemob_account;//": "环信账号",
//@property (nonatomic, copy) NSString * msg_count;//": "消息数",
@property (nonatomic, copy) NSString * last_content;//": "内容",
@property (nonatomic, copy) NSString * last_time;//": "时间"

@property (nonatomic, copy) NSString * stage_title;//": "消息数",
@property (nonatomic, copy) NSString * stage_time;//": "内容",
@property (nonatomic, copy) NSString * stage_count;//": "时间"


//分销店铺消息
@property (nonatomic, copy) NSString * type;//": "消息数",
@property (nonatomic, copy) NSString * uid;//": "内容",
@property (nonatomic, copy) NSString * bid;//": "时间"

- (void)sUserMessageNewMsgSuccess:(SUserMessageNewMsgSuccessBlock)success andFailure:(SUserMessageNewMsgFailureBlock)failure;

- (void)sendMessageNewMsgSuccess:(sendMessageNewMsgSuccess)success andFailure:(SUserMessageNewMsgFailureBlock)failure ;

@end
