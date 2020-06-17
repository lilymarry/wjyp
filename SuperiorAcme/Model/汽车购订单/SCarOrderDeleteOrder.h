//
//  SCarOrderDeleteOrder.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SCarOrderDeleteOrderSuccessBlock) (NSString * code, NSString * message);
typedef void(^SCarOrderDeleteOrderFailureBlock) (NSError * error);

@interface SCarOrderDeleteOrder : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单ID

- (void)sCarOrderDeleteOrderSuccess:(SCarOrderDeleteOrderSuccessBlock)success andFailure:(SCarOrderDeleteOrderFailureBlock)failure;
@end
