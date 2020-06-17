//
//  SOrderCommentOrder.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/7.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SOrderCommentOrderSuccessBlock) (NSString * code, NSString * message);
typedef void(^SOrderCommentOrderFailureBlock) (NSError * error);

@interface SOrderCommentOrder : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单id    否    文本    1
@property (nonatomic, copy) NSString * merchant_star;//    商家评分星级1-5    是    文本    1
@property (nonatomic, copy) NSString * delivery_star;//    配送评分星级
@property (nonatomic, copy) NSString * order_type;//    订单类型 1普通订单 2拼单购 3无界预购 4比价购 5无界商店

- (void)sOrderCommentOrderSuccess:(SOrderCommentOrderSuccessBlock)success andFailure:(SOrderCommentOrderFailureBlock)failure;
@end
