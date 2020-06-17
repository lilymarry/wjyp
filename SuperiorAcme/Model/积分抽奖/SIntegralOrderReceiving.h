//
//  SIntegralOrderReceiving.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SIntegralOrderReceivingSuccessBlock) (NSString * code, NSString * message);
typedef void(^SIntegralOrderReceivingFailureBlock) (NSError * error);

@interface SIntegralOrderReceiving : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单id

- (void)sIntegralOrderReceivingSuccess:(SIntegralOrderReceivingSuccessBlock)success andFailure:(SIntegralOrderReceivingFailureBlock)failure;
@end
