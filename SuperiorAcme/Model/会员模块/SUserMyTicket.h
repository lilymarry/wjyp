//
//  SUserMyTicket.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserMyTicketSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SUserMyTicketFailureBlock) (NSError * error);

@interface SUserMyTicket : NSObject

@property (nonatomic, strong) SUserMyTicket * data;

@property (nonatomic, copy) NSArray * normal;//未使用
@property (nonatomic, copy) NSArray * out;//已失效

@property (nonatomic, copy) NSString * userticket_id;//"票券ID",
@property (nonatomic, copy) NSString * user_id;//"用户ID",
@property (nonatomic, copy) NSString * ticket_name;//"票券名称",
@property (nonatomic, copy) NSString * ticket_desc;//"票券描述",
@property (nonatomic, copy) NSString * ticket_type;//"票券类型",//1满减 2 满折 3满赠
@property (nonatomic, copy) NSString * value;//满减=>金额 满折=>折扣 满赠=>商品id

/*
 *添加优惠券描述属性
 */
@property (nonatomic, copy) NSString * value_replace;//优惠券描述

@property (nonatomic, copy) NSString * condition;//消费满足条件
@property (nonatomic, copy) NSString * merchant_id;//"店铺ID",
@property (nonatomic, copy) NSString * picture;//"店铺Logo",
@property (nonatomic, copy) NSString * end_time;//'失效时间'

- (void)sUserMyTicketSuccess:(SUserMyTicketSuccessBlock)success andFailure:(SUserMyTicketFailureBlock)failure;
@end
