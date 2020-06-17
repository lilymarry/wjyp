//
//  SMemberOrderSettlement.h
//  SuperiorAcme
//
//  Created by GYM on 2018/1/31.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SMemberOrderSettlementSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SMemberOrderSettlementFailureBlock) (NSError * error);

@interface SMemberOrderSettlement : NSObject
@property (nonatomic, copy) NSString * member_coding;//    会员卡id    否    文本    1

@property (nonatomic, strong) SMemberOrderSettlement * data;
@property (nonatomic, copy) NSString * rank_name;//": "无界会员",             // 会员卡名
@property (nonatomic, copy) NSString * prescription;//”                 // 年限
@property (nonatomic, copy) NSString * rank_id;//": "1",                    // 会员id
@property (nonatomic, copy) NSString * pay_money;//": "10.00",        // 金额
@property (nonatomic, copy) NSString * is_integral;//": "1",                    // 是否使用积分（0->否，1->是）
@property (nonatomic, copy) NSString * integral_price;//":"//积分支付结算金额"
@property (nonatomic, copy) NSString * balance;//": "30.00",    // 用户余额
@property (nonatomic, copy) NSString * integral;//": "40.00"       //用户积分

- (void)sMemberOrderSettlementSuccess:(SMemberOrderSettlementSuccessBlock)success andFailure:(SMemberOrderSettlementFailureBlock)failure;
@end
