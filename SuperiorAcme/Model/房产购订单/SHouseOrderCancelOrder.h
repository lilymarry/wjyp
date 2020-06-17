//
//  SHouseOrderCancelOrder.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SHouseOrderCancelOrderSuccessBlock) (NSString * code, NSString * message);
typedef void(^SHouseOrderCancelOrderFailureBlock) (NSError * error);

@interface SHouseOrderCancelOrder : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单ID

- (void)sHouseOrderCancelOrderSuccess:(SHouseOrderCancelOrderSuccessBlock)success andFailure:(SHouseOrderCancelOrderFailureBlock)failure;
@end
