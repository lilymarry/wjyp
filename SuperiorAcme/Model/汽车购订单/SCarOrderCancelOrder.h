//
//  SCarOrderCancelOrder.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SCarOrderCancelOrderSuccessBlock) (NSString * code, NSString * message);
typedef void(^SCarOrderCancelOrderFailureBlock) (NSError * error);

@interface SCarOrderCancelOrder : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单id

- (void)sCarOrderCancelOrderSuccess:(SCarOrderCancelOrderSuccessBlock)success andFailure:(SCarOrderCancelOrderFailureBlock)failure;
@end
