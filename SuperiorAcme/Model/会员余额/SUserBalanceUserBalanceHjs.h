//
//  SUserBalanceUserBalanceHjs.h
//  SuperiorAcme
//
//  Created by GYM on 2018/3/20.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserBalanceUserBalanceHjsSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserBalanceUserBalanceHjsFailureBlock) (NSError * error);

@interface SUserBalanceUserBalanceHjs : NSObject
@property (nonatomic, copy) NSString * pay_status;//
@property (nonatomic, copy) NSString * p;//

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * id;//": "1",//订单ID
@property (nonatomic, copy) NSString * order_sn;//": "1520466392345",//订单编号
@property (nonatomic, copy) NSString * create_time;//": "2018-03-08 07:46:32",//创建时间
@property (nonatomic, copy) NSString * pay_time;//": "1970-01-01 08:00:00",//支付时间
@property (nonatomic, copy) NSString * money;//": "1.00",//充值金额
@property (nonatomic, copy) NSString * pay_type;//": "1",//1微信  2支付宝 支付方式
@property (nonatomic, copy) NSString * status;//": "0"//未支付  1已支付 5取消

- (void)sUserBalanceUserBalanceHjsSuccess:(SUserBalanceUserBalanceHjsSuccessBlock)success andFailure:(SUserBalanceUserBalanceHjsFailureBlock)failure;
@end
