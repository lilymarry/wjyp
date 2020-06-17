//
//  SGroupBuyOrderCancelOrder.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SGroupBuyOrderCancelOrderSuccessBlock) (NSString * code, NSString * message);
typedef void(^SGroupBuyOrderCancelOrderFailureBlock) (NSError * error);

@interface SGroupBuyOrderCancelOrder : NSObject
@property (nonatomic, copy) NSString * group_buy_order_id;//    订单id

- (void)sGroupBuyOrderCancelOrderSuccess:(SGroupBuyOrderCancelOrderSuccessBlock)success andFailure:(SGroupBuyOrderCancelOrderFailureBlock)failure;
@end
