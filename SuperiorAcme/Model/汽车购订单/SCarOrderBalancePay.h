//
//  SCarOrderBalancePay.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SCarOrderBalancePaySuccessBlock) (NSString * code, NSString * message);
typedef void(^SCarOrderBalancePayFailureBlock) (NSError * error);

@interface SCarOrderBalancePay : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单ID    否    文本    1
@property (nonatomic, copy) NSString * discount_type;//    使用代金券： 0不使用代金券 1使用红券 2使用黄券 3使用蓝券;

- (void)sCarOrderBalancePaySuccess:(SCarOrderBalancePaySuccessBlock)success andFailure:(SCarOrderBalancePayFailureBlock)failure;
@end
