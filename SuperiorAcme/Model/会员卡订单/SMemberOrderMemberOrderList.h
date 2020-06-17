//
//  SMemberOrderMemberOrderList.h
//  SuperiorAcme
//
//  Created by GYM on 2018/3/13.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SMemberOrderMemberOrderListSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SMemberOrderMemberOrderListFailureBlock) (NSError * error);

@interface SMemberOrderMemberOrderList : NSObject
@property (nonatomic, copy) NSString * pay_status;//    默认不传 0未支付 1已支付    否    文本    1
@property (nonatomic, copy) NSString * p;//    分页参数

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * id;//": "1",//订单ID
@property (nonatomic, copy) NSString * order_sn;//": "152050386342199",//订单号
@property (nonatomic, copy) NSString * create_time;//": "1520503863",//购买时间
@property (nonatomic, copy) NSString * rank_name;//": "无忧会员",//会员卡类型；
@property (nonatomic, copy) NSString * validity;//": 1//有效期 单位：年
@property (nonatomic, copy) NSString * order_status;//":""//1未支付 2已支付  5已取消
@property (nonatomic, copy) NSString * member_coding;//

- (void)sMemberOrderMemberOrderListSuccess:(SMemberOrderMemberOrderListSuccessBlock)success andFailure:(SMemberOrderMemberOrderListFailureBlock)failure;
@end
