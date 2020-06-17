//
//  SIntegralBuyOrderReceiving.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/18.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SIntegralBuyOrderReceivingSuccessBlock) (NSString * code, NSString * message);
typedef void(^SIntegralBuyOrderReceivingFailureBlock) (NSError * error);

@interface SIntegralBuyOrderReceiving : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单ID

- (void)sIntegralBuyOrderReceivingSuccess:(SIntegralBuyOrderReceivingSuccessBlock)success andFailure:(SIntegralBuyOrderReceivingFailureBlock)failure;
@end
