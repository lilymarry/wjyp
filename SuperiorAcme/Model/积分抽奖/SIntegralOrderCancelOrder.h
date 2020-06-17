//
//  SIntegralOrderCancelOrder.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SIntegralOrderCancelOrderSuccessBlock) (NSString * code, NSString * message);
typedef void(^SIntegralOrderCancelOrderFailureBlock) (NSError * error);

@interface SIntegralOrderCancelOrder : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单id

- (void)sIntegralOrderCancelOrderSuccess:(SIntegralOrderCancelOrderSuccessBlock)success andFailure:(SIntegralOrderCancelOrderFailureBlock)failure;
@end
