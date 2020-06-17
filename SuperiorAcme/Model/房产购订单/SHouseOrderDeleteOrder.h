//
//  SHouseOrderDeleteOrder.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SHouseOrderDeleteOrderSuccessBlock) (NSString * code, NSString * message);
typedef void(^SHouseOrderDeleteOrderFailureBlock) (NSError * error);

@interface SHouseOrderDeleteOrder : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单ID

- (void)sHouseOrderDeleteOrderSuccess:(SHouseOrderDeleteOrderSuccessBlock)success andFailure:(SHouseOrderDeleteOrderFailureBlock)failure;
@end
