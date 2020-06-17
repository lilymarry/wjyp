//
//  SGroupBuyOrderDeleteOrder.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SGroupBuyOrderDeleteOrderSuccessBlock) (NSString * code, NSString * message);
typedef void(^SGroupBuyOrderDeleteOrderFailureBlock) (NSError * error);

@interface SGroupBuyOrderDeleteOrder : NSObject
@property (nonatomic, copy) NSString * group_buy_order_id;//    订单ID

- (void)sGroupBuyOrderDeleteOrderSuccess:(SGroupBuyOrderDeleteOrderSuccessBlock)success andFailure:(SGroupBuyOrderDeleteOrderFailureBlock)failure;
@end
