//
//  SUserBalanceUnderMoneys.h
//  SuperiorAcme
//
//  Created by GYM on 2018/2/23.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserBalanceUnderMoneysSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserBalanceUnderMoneysFailureBlock) (NSError * error);

@interface SUserBalanceUnderMoneys : NSObject
@property (nonatomic, copy) NSString * p;//    分页参数

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * time;//": "1970-01",
@property (nonatomic, copy) NSArray * list;
@property (nonatomic, copy) NSString * id;//": "1",
@property (nonatomic, copy) NSString * money;//": "50.00",
@property (nonatomic, copy) NSString * create_time;//": "1970-01-01 08:00:00",
@property (nonatomic, copy) NSString * status;//": "2"
@property (nonatomic, copy) NSString * img;//
@property (nonatomic, copy) NSString * chat;//该订单已删除

//赠送蓝色券某条具体明细
@property (nonatomic, copy) NSString * b_v_id;//id
@property (nonatomic, copy) NSString * order_id;//订单id
@property (nonatomic, copy) NSString * order_sn;//订单编号
@property (nonatomic, copy) NSString * voucher_price;//使用金额 都是减少
@property (nonatomic, copy) NSString * order_type;//0普通订单 （暂时只有普通订单）
@property (nonatomic, copy) NSString * reason;//"无界新人1508购买订单号152671682457124消费23.80元蓝色代金券。"//描述

@property (nonatomic, copy) NSString * status_type;// 1赠送蓝色券某条具体明细 nil赠送蓝色券明细
@property (nonatomic, copy) NSString * voucher_id;// 赠送蓝色券某条具体明细的id 

- (void)sUserBalanceUnderMoneysSuccess:(SUserBalanceUnderMoneysSuccessBlock)success andFailure:(SUserBalanceUnderMoneysFailureBlock)failure;
@end
