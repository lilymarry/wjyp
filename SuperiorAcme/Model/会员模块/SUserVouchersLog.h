//
//  SUserVouchersLog.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserVouchersLogSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserVouchersLogFailureBlock) (NSError * error);

@interface SUserVouchersLog : NSObject
@property (nonatomic, copy) NSString * p;//分页参数
@property (nonatomic, copy) NSString * giveStatus;//1 是赠送明细  0代金券明细
@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * time;

@property (nonatomic, copy) NSArray * list;
@property (nonatomic, copy) NSString * log_id;//"记录ID",
@property (nonatomic, copy) NSString * act_type;//操作类型 0后台操作1购买会员卡 2普通商品消费  3退回 4积分兑换获得
@property (nonatomic, copy) NSString * reason;//"原因",
@property (nonatomic, copy) NSString * create_time;//"创建时间",
@property (nonatomic, copy) NSString * money;// "交易金额"
@property (nonatomic, copy) NSString * img;//
@property (nonatomic, copy) NSString * add_sub;//":"0增加  1减少"
@property (nonatomic, copy) NSString * order_id;
@property (nonatomic, copy) NSString * order_status;//会员卡订单状态
@property (nonatomic, copy) NSString * member_coding;//会员卡id
@property (nonatomic, copy) NSString * chat;//该订单已删除

- (void)sUserVouchersLogSuccess:(SUserVouchersLogSuccessBlock)success andFailure:(SUserVouchersLogFailureBlock)failure;
@end
