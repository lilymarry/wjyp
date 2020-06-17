//
//  SLimitBuyOrderReceiving.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SLimitBuyOrderReceivingSuccessBlock) (NSString * code, NSString * message);
typedef void(^SLimitBuyOrderReceivingFailureBlock) (NSError * error);

@interface SLimitBuyOrderReceiving : NSObject
@property (nonatomic, copy) NSString * limit_buy_order_id;//    订单id

- (void)sLimitBuyOrderReceivingSuccess:(SLimitBuyOrderReceivingSuccessBlock)success andFailure:(SLimitBuyOrderReceivingFailureBlock)failure;
@end
