//
//  SAuctionOrderCancelOrder.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SAuctionOrderCancelOrderSuccessBlock) (NSString * code, NSString * message);
typedef void(^SAuctionOrderCancelOrderFailureBlock) (NSError * error);

@interface SAuctionOrderCancelOrder : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单id

- (void)sAuctionOrderCancelOrderSuccess:(SAuctionOrderCancelOrderSuccessBlock)success andFailure:(SAuctionOrderCancelOrderFailureBlock)failure;
@end
