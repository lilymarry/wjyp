//
//  SAfterSaleCancelAfter.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/12.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SAfterSaleCancelAfterSuccessBlock) (NSString * code, NSString * message);
typedef void(^SAfterSaleCancelAfterFailureBlock) (NSError * error);

@interface SAfterSaleCancelAfter : NSObject
@property (nonatomic, copy) NSString * back_apply_id;//    售后id    否    文本    1
@property (nonatomic, copy) NSString * order_goods_id;//    订单商品id

- (void)sAfterSaleCancelAfterSuccess:(SAfterSaleCancelAfterSuccessBlock)success andFailure:(SAfterSaleCancelAfterFailureBlock)failure;
@end
