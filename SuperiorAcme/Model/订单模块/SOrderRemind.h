//
//  SOrderRemind.h
//  SuperiorAcme
//
//  Created by GYM on 2018/3/21.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SOrderRemindSuccessBlock) (NSString * code, NSString * message);
typedef void(^SOrderRemindFailureBlock) (NSError * error);

@interface SOrderRemind : NSObject
@property (nonatomic, copy) NSString * order_goods_id;//    订单商品ID

@property (nonatomic, copy) NSString * group_buy_order_id; //拼团订单商品ID

@property (nonatomic, copy) NSString * order_id; //无界商店订单商品ID

@property (nonatomic, copy) NSString * orderType;

- (void)sOrderRemindSuccess:(SOrderRemindSuccessBlock)success andFailure:(SOrderRemindFailureBlock)failure;
@end
