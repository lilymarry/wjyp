//
//  SPreOrderPreDeleteOrder.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SPreOrderPreDeleteOrderSuccessBlock) (NSString * code, NSString * message);
typedef void(^SPreOrderPreDeleteOrderFailureBlock) (NSError * error);

@interface SPreOrderPreDeleteOrder : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单id

- (void)sPreOrderPreDeleteOrderSuccess:(SPreOrderPreDeleteOrderSuccessBlock)success andFailure:(SPreOrderPreDeleteOrderFailureBlock)failure;
@end
