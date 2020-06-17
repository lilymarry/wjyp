//
//  SAfterSaleAddShipping.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/12.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SAfterSaleAddShippingSuccessBlock) (NSString * code, NSString * message);
typedef void(^SAfterSaleAddShippingFailureBlock) (NSError * error);

@interface SAfterSaleAddShipping : NSObject
@property (nonatomic, copy) NSString * shipping_id;//    快递公司id    否    文本    1
@property (nonatomic, copy) NSString * invoice;//    快递单号    否    文本    10086
@property (nonatomic, copy) NSString * back_apply_id;//    退货ID
@property (nonatomic, copy) NSString * receiver;//    联系人姓名    否    文本    联系人
@property (nonatomic, copy) NSString * receiver_phone;//    '联系方式    否    文本    联系方式
@property (nonatomic, copy) NSString * province;//    省ID    否    文本    1
@property (nonatomic, copy) NSString * city;//    市ID    否    文本    2
@property (nonatomic, copy) NSString * area;//    区ID    否    文本    3
@property (nonatomic, copy) NSString * street;//    街道ID    否    文本    4
@property (nonatomic, copy) NSString * address;//    详细地址

- (void)sAfterSaleAddShippingSuccess:(SAfterSaleAddShippingSuccessBlock)success andFailure:(SAfterSaleAddShippingFailureBlock)failure;
@end
