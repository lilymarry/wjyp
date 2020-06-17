//
//  SGroupBuyOrderBalancePay.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SGroupBuyOrderBalancePaySuccessBlock) (NSString * code, NSString * message);
typedef void(^SGroupBuyOrderBalancePayFailureBlock) (NSError * error);

@interface SGroupBuyOrderBalancePay : NSObject
@property (nonatomic, copy) NSString * group_buy_order_id;//    订单ID    否    文本    1
@property (nonatomic, copy) NSString * discount_type;//    使用代金券：0不使用代金券 1使用红券 2使用黄券 3使用蓝(多个选择用','隔开)

- (void)sGroupBuyOrderBalancePaySuccess:(SGroupBuyOrderBalancePaySuccessBlock)success andFailure:(SGroupBuyOrderBalancePayFailureBlock)failure;
@end
