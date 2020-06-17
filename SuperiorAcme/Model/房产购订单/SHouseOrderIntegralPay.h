//
//  SHouseOrderIntegralPay.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/30.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SHouseOrderIntegralPaySuccessBlock) (NSString * code, NSString * message);
typedef void(^SHouseOrderIntegralPayFailureBlock) (NSError * error);

@interface SHouseOrderIntegralPay : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单ID

- (void)sHouseOrderIntegralPaySuccess:(SHouseOrderIntegralPaySuccessBlock)success andFailure:(SHouseOrderIntegralPayFailureBlock)failure;
@end
