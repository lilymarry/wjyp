//
//  SgiftOrderdelayReceiving.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/26.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SgiftOrderdelayReceivingSuccessBlock) (NSString * code, NSString * message);
typedef void(^SgiftOrderdelayReceivingFailureBlock) (NSError * error);
@interface SgiftOrderdelayReceiving : NSObject
@property (nonatomic, copy) NSString * order_goods_id;//    订单ID

- (void)SgiftOrderdelayReceivingSuccess:(SgiftOrderdelayReceivingSuccessBlock)success andFailure:(SgiftOrderdelayReceivingFailureBlock)failure;
@end
