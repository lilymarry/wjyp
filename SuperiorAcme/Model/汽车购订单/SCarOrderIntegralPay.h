//
//  SCarOrderIntegralPay.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SCarOrderIntegralPaySuccessBlock) (NSString * code, NSString * message);
typedef void(^SCarOrderIntegralPayFailureBlock) (NSError * error);

@interface SCarOrderIntegralPay : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单ID

- (void)sCarOrderIntegralPaySuccess:(SCarOrderIntegralPaySuccessBlock)success andFailure:(SCarOrderIntegralPayFailureBlock)failure;
@end
