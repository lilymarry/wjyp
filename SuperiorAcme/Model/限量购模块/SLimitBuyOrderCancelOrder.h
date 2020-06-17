//
//  SLimitBuyOrderCancelOrder.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SLimitBuyOrderCancelOrderSuccessBlock) (NSString * code, NSString * message);
typedef void(^SLimitBuyOrderCancelOrderFailureBlock) (NSError * error);

@interface SLimitBuyOrderCancelOrder : NSObject
@property (nonatomic, copy) NSString * limit_buy_order_id;//    订单id

- (void)sLimitBuyOrderCancelOrderSuccess:(SLimitBuyOrderCancelOrderSuccessBlock)success andFailure:(SLimitBuyOrderCancelOrderFailureBlock)failure;
@end
