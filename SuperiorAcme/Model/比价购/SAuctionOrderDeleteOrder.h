//
//  SAuctionOrderDeleteOrder.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SAuctionOrderDeleteOrderSuccessBlock) (NSString * code, NSString * message);
typedef void(^SAuctionOrderDeleteOrderFailureBlock) (NSError * error);

@interface SAuctionOrderDeleteOrder : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单id

- (void)sAuctionOrderDeleteOrderSuccess:(SAuctionOrderDeleteOrderSuccessBlock)success andFailure:(SAuctionOrderDeleteOrderFailureBlock)failure;
@end
