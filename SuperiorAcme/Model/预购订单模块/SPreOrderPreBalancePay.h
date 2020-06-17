//
//  SPreOrderPreBalancePay.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SPreOrderPreBalancePaySuccessBlock) (NSString * code, NSString * message);
typedef void(^SPreOrderPreBalancePayFailureBlock) (NSError * error);

@interface SPreOrderPreBalancePay : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单ID    否    文本    1
@property (nonatomic, copy) NSString * discount_type;//    使用代金券：0不使用代金券 1使用红券 2使用黄券 3使用蓝(多个选择用','隔开)

- (void)sPreOrderPreBalancePaySuccess:(SPreOrderPreBalancePaySuccessBlock)success andFailure:(SPreOrderPreBalancePayFailureBlock)failure;
@end
