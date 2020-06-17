//
//  SPreOrderPreCancelOrder.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SPreOrderPreCancelOrderSuccessBlock) (NSString * code, NSString * message);
typedef void(^SPreOrderPreCancelOrderFailureBlock) (NSError * error);

@interface SPreOrderPreCancelOrder : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单id

- (void)sPreOrderPreCancelOrderSuccess:(SPreOrderPreCancelOrderSuccessBlock)success andFailure:(SPreOrderPreCancelOrderFailureBlock)failure;
@end
