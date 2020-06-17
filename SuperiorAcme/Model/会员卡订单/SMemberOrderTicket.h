//
//  SMemberOrderTicket.h
//  SuperiorAcme
//
//  Created by GYM on 2018/2/2.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SMemberOrderTicketSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SMemberOrderTicketFailureBlock) (NSError * error);

@interface SMemberOrderTicket : NSObject
@property (nonatomic, copy) NSString * member_coding;//    会员卡id    否    文本    1
@property (nonatomic, copy) NSString * number;//    数量

@property (nonatomic, strong) SMemberOrderTicket * data;
@property (nonatomic, copy) NSString * discount;//": "10.00",                // 红券金额
@property (nonatomic, copy) NSString * yellow_discount;//": "30.00",    // 黄券金额
@property (nonatomic, copy) NSString * blue_discount;//": "40.00"       //蓝券金额
@property (nonatomic, copy) NSString * red_desc;//": ""//红券说明
@property (nonatomic, copy) NSString * yellow_desc;//": ""//黄券说明
@property (nonatomic, copy) NSString * blue_desc;//": ""//蓝券说明
@property (nonatomic, copy) NSString * discount_price;//":"红券"
@property (nonatomic, copy) NSString * yellow_price;//":"黄券"
@property (nonatomic, copy) NSString * blue_price;//":"蓝券"



- (void)sMemberOrderTicketSuccess:(SMemberOrderTicketSuccessBlock)success andFailure:(SMemberOrderTicketFailureBlock)failure;
@end
