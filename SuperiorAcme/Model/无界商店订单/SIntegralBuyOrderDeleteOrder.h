//
//  SIntegralBuyOrderDeleteOrder.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/18.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SIntegralBuyOrderDeleteOrderSuccessBlock) (NSString * code, NSString * message);
typedef void(^SIntegralBuyOrderDeleteOrderFailureBlock) (NSError * error);

@interface SIntegralBuyOrderDeleteOrder : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单ID

- (void)sIntegralBuyOrderDeleteOrderSuccess:(SIntegralBuyOrderDeleteOrderSuccessBlock)success andFailure:(SIntegralBuyOrderDeleteOrderFailureBlock)failure;
@end
