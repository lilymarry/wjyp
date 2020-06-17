//
//  SLimitBuyOrderDeleteOrder.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SLimitBuyOrderDeleteOrderSuccessBlock) (NSString * code, NSString * message);
typedef void(^SLimitBuyOrderDeleteOrderFailureBlock) (NSError * error);

@interface SLimitBuyOrderDeleteOrder : NSObject
@property (nonatomic, copy) NSString * limit_buy_order_id;//    订单id

- (void)sLimitBuyOrderDeleteOrderSuccess:(SLimitBuyOrderDeleteOrderSuccessBlock)success andFailure:(SLimitBuyOrderDeleteOrderFailureBlock)failure;
@end
