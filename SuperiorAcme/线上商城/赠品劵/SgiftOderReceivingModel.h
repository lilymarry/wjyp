//
//  SgiftOderReceivingModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/26.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SgiftOderReceivingModelSuccessBlock) (NSString * code, NSString * message);
typedef void(^SgiftOderReceivingModelFailureBlock) (NSError * error);
@interface SgiftOderReceivingModel : NSObject



@property (nonatomic, copy) NSString * order_id;//    订单ID
@property (nonatomic, copy) NSString * status;//    订单ID
- (void)SgiftOderReceivingModelSuccess:(SgiftOderReceivingModelSuccessBlock)success andFailure:(SgiftOderReceivingModelFailureBlock)failure;
@end
