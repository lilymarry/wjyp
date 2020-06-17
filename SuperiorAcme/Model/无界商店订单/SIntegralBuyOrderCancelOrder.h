//
//  SIntegralBuyOrderCancelOrder.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/18.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SIntegralBuyOrderCancelOrderSuccessBlock) (NSString * code, NSString * message);
typedef void(^SIntegralBuyOrderCancelOrderFailureBlock) (NSError * error);

@interface SIntegralBuyOrderCancelOrder : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单ID

- (void)sIntegralBuyOrderCancelOrderSuccess:(SIntegralBuyOrderCancelOrderSuccessBlock)success andFailure:(SIntegralBuyOrderCancelOrderFailureBlock)failure;
@end
