//
//  SAfterSaleBackApply.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SAfterSaleBackApplySuccessBlock) (NSString * code, NSString * message);
typedef void(^SAfterSaleBackApplyFailureBlock) (NSError * error);

@interface SAfterSaleBackApply : NSObject
@property (nonatomic, copy) NSString * reason;//    售后类型 1我要退款 2我要退货    否    文本    1
@property (nonatomic, copy) NSString * back_money;//    退款金额    是    文本    10.00
@property (nonatomic, copy) NSString * back_desc;//    退款说明    是    文本    退款说明
@property (nonatomic, strong) NSDictionary * back_img;//    凭证    是    文本    凭证相片
@property (nonatomic, copy) NSString * cause;//    售后原因id    否    文本    1
@property (nonatomic, copy) NSString * goods_status;//    货物状态 已收到货  未收到货    否    文本    1
@property (nonatomic, copy) NSString * order_id;//订单id    否    文本    1
@property (nonatomic, copy) NSString * order_type;//    订单类型 1普通订单 2拼单购 3无界预购 4比价购 5积分抽奖    否    文本    1
@property (nonatomic, copy) NSString * order_goods_id;//    订单商品表id

- (void)sAfterSaleBackApplySuccess:(SAfterSaleBackApplySuccessBlock)success andFailure:(SAfterSaleBackApplyFailureBlock)failure;
@end
