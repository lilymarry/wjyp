//
//  SIntegralOrderBalancePay.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SIntegralOrderBalancePaySuccessBlock) (NSString * code, NSString * message);
typedef void(^SIntegralOrderBalancePayFailureBlock) (NSError * error);

@interface SIntegralOrderBalancePay : NSObject
@property (nonatomic, copy) NSString * pay_type;//    支付方式（1：余额；2：积分；3：红券；4：黄券；5：蓝券）

- (void)sIntegralOrderBalancePaySuccess:(SIntegralOrderBalancePaySuccessBlock)success andFailure:(SIntegralOrderBalancePayFailureBlock)failure;
@end
