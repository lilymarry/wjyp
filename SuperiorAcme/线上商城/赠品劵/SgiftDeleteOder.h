//
//  SgiftDeleteOder.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/26.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SgiftDeleteOderSuccessBlock) (NSString * code, NSString * message);
typedef void(^SgiftDeleteOderFailureBlock) (NSError * error);
@interface SgiftDeleteOder : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单ID

- (void)SgiftDeleteOderModelSuccess:(SgiftDeleteOderSuccessBlock)success andFailure:(SgiftDeleteOderFailureBlock)failure;
@end
