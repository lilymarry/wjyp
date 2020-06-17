//
//  SGroupBuyOrderReceiving.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SGroupBuyOrderReceivingSuccessBlock) (NSString * code, NSString * message);
typedef void(^SGroupBuyOrderReceivingFailureBlock) (NSError * error);

@interface SGroupBuyOrderReceiving : NSObject
@property (nonatomic, copy) NSString * group_buy_order_id;//    订单id
@property (nonatomic, copy) NSString * status;//    状态（2->放弃，1->确认）

- (void)sGroupBuyOrderReceivingSuccess:(SGroupBuyOrderReceivingSuccessBlock)success andFailure:(SGroupBuyOrderReceivingFailureBlock)failure;
@end
