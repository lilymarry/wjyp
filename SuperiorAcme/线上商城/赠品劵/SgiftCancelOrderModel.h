//
//  SgiftCancelOrderModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/26.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^SgiftCancelOrderModelSuccessBlock) (NSString * code, NSString * message);
typedef void(^SgiftCancelOrderModelFailureBlock) (NSError * error);
@interface SgiftCancelOrderModel : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单ID

- (void)SgiftCancelOrderModelSuccess:(SgiftCancelOrderModelSuccessBlock)success andFailure:(SgiftCancelOrderModelFailureBlock)failure;
@end
