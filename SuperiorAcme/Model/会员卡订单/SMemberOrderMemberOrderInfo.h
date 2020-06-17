//
//  SMemberOrderMemberOrderInfo.h
//  SuperiorAcme
//
//  Created by GYM on 2018/3/13.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SMemberOrderMemberOrderInfoSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SMemberOrderMemberOrderInfoFailureBlock) (NSError * error);

@interface SMemberOrderMemberOrderInfo : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单ID

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * order_name;//": "id",
@property (nonatomic, copy) NSString * order_value;// "2"

- (void)sMemberOrderMemberOrderInfoSuccess:(SMemberOrderMemberOrderInfoSuccessBlock)success andFailure:(SMemberOrderMemberOrderInfoFailureBlock)failure;
@end
