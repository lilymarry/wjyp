//
//  SOrderDelayReceiving.h
//  SuperiorAcme
//
//  Created by GYM on 2018/2/13.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SOrderDelayReceivingSuccessBlock) (NSString * code, NSString * message);
typedef void(^SOrderDelayReceivingFailureBlock) (NSError * error);

@interface SOrderDelayReceiving : NSObject
@property (nonatomic, copy) NSString * order_goods_id;//    订单商品表id

@property (nonatomic, copy) NSString * orderType;

- (void)sOrderDelayReceivingSuccess:(SOrderDelayReceivingSuccessBlock)success andFailure:(SOrderDelayReceivingFailureBlock)failure;
@end
