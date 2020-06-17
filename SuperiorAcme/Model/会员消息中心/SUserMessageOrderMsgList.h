//
//  SUserMessageOrderMsgList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserMessageOrderMsgListSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserMessageOrderMsgListFailureBlock) (NSError * error);

@interface SUserMessageOrderMsgList : NSObject
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * id;//": "订单消息id",
@property (nonatomic, copy) NSString * user_id;//": "会员id",
@property (nonatomic, copy) NSString * content;//": "您的订单已签收",//消息内容
@property (nonatomic, copy) NSString * create_time;//": "0",//时间
@property (nonatomic, copy) NSString * status;//": "0" //0 未读 1已读
@property (nonatomic, copy) NSString * order_id;
@property (nonatomic, copy) NSString * type;//0商品 1会员卡

@property (nonatomic, copy) NSString * order_status;//会员卡订单状态
@property (nonatomic, copy) NSString * member_coding;//会员卡id
@property (nonatomic, copy) NSString * chat;//该订单已删除

- (void)sUserMessageOrderMsgListSuccess:(SUserMessageOrderMsgListSuccessBlock)success andFailure:(SUserMessageOrderMsgListFailureBlock)failure;
@end
