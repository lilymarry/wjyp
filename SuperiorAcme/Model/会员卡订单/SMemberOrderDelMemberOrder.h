//
//  SMemberOrderDelMemberOrder.h
//  SuperiorAcme
//
//  Created by GYM on 2018/3/13.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SMemberOrderDelMemberOrderSuccessBlock) (NSString * code, NSString * message);
typedef void(^SMemberOrderDelMemberOrderFailureBlock) (NSError * error);

@interface SMemberOrderDelMemberOrder : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单ID    否    文本    1
@property (nonatomic, copy) NSString * order_status;//    必须传 5已取消 9 已删除

- (void)sMemberOrderDelMemberOrderSuccess:(SMemberOrderDelMemberOrderSuccessBlock)success andFailure:(SMemberOrderDelMemberOrderFailureBlock)failure;
@end
