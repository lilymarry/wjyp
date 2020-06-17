//
//  SUserBalanceBalanceLog.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserBalanceBalanceLogSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserBalanceBalanceLogFailureBlock) (NSError * error);

@interface SUserBalanceBalanceLog : NSObject
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * time;//"2017-09",//日期
@property (nonatomic, copy) NSArray * list;
@property (nonatomic, copy) NSString * log_id;//": "记录id",
@property (nonatomic, copy) NSString * act_type;//": "2",//行为类型 1线上充值 2线下充值 3消费 4提现 5退款 6转账出 7转账入,8平台后台增加，9平台后台减少，10购买会员资格 11接受蓝券的人消费使用蓝券获得余额 17线下店铺消费 18线下获得
@property (nonatomic, copy) NSString * act_id;
@property (nonatomic, copy) NSString * reason;//": "线下充值40元",//原因
@property (nonatomic, copy) NSString * create_time;//": "2017-09-21 16:05",//创建时间
@property (nonatomic, copy) NSString * money;//": "40.00"//金额
@property (nonatomic, copy) NSString * img;//
@property (nonatomic, copy) NSString * add_sub;//1:- 2:+

@property (nonatomic, copy) NSString * order_id;
@property (nonatomic, copy) NSString * order_status;//会员卡订单状态
@property (nonatomic, copy) NSString * member_coding;//会员卡id
@property (nonatomic, copy) NSString * chat;//该订单已删除
@property (nonatomic, copy) NSString * profession;//分销所得积分



- (void)sUserBalanceBalanceLogSuccess:(SUserBalanceBalanceLogSuccessBlock)success andFailure:(SUserBalanceBalanceLogFailureBlock)failure;
@end
