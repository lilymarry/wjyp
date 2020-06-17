//
//  SOrderCancelOrder.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/6.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SOrderCancelOrderSuccessBlock) (NSString * code, NSString * message);
typedef void(^SOrderCancelOrderFailureBlock) (NSError * error);

@interface SOrderCancelOrder : NSObject
@property (nonatomic, copy) NSString * order_id;  //    订单id
@property (nonatomic, copy) NSString *order_type; //    无界商店

- (void)sOrderCancelOrderSuccess:(SOrderCancelOrderSuccessBlock)success andFailure:(SOrderCancelOrderFailureBlock)failure;
@end
