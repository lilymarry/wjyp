//
//  SOrderDeleteOrder.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/6.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SOrderDeleteOrderSuccessBlock) (NSString * code, NSString * message);
typedef void(^SOrderDeleteOrderFailureBlock) (NSError * error);

@interface SOrderDeleteOrder : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单ID

- (void)sOrderDeleteOrderSuccess:(SOrderDeleteOrderSuccessBlock)success andFailure:(SOrderDeleteOrderFailureBlock)failure;
@end
