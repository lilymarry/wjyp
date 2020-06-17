//
//  SOrderReceiving.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/7.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SOrderReceivingSuccessBlock) (NSString * code, NSString * message);
typedef void(^SOrderReceivingFailureBlock) (NSError * error);

@interface SOrderReceiving : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单id
@property (nonatomic, copy) NSString * order_goods_id;//    订单商品表id    否    文本    1
@property (nonatomic, copy) NSString * status;//    状态（2->放弃，1->确认）

@property (nonatomic, copy) NSString * orderType; //无界商店

- (void)sOrderReceivingSuccess:(SOrderReceivingSuccessBlock)success andFailure:(SOrderReceivingFailureBlock)failure;
@end
