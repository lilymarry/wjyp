//
//  SAfterSaleBackApplyType.h
//  SuperiorAcme
//
//  Created by GYM on 2018/2/13.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SAfterSaleBackApplyTypeSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SAfterSaleBackApplyTypeFailureBlock) (NSError * error);

@interface SAfterSaleBackApplyType : NSObject
@property (nonatomic, copy) NSString * order_goods_id;//    订单商品表id

@property (nonatomic, strong) SAfterSaleBackApplyType * data;
@property (nonatomic, copy) NSString * money_status;//": 1,             // 订单商品状态（0->不能退款，1->能退款）
@property (nonatomic, copy) NSString * after_desc;//"售后描述"

@property (nonatomic, copy) NSArray * list;
@property (nonatomic, copy) NSString * type_id;//": "1"      // 类型id
@property (nonatomic, copy) NSString * name;//": "退货退款"           //类型名

@property (nonatomic, copy) NSArray * goods_status;
//"name": "已收到货"           //类型名


/**
 订单类型 2：拼单购
 */
@property (nonatomic, strong) NSString *order_type;

- (void)sAfterSaleBackApplyTypeSuccess:(SAfterSaleBackApplyTypeSuccessBlock)success andFailure:(SAfterSaleBackApplyTypeFailureBlock)failure;
@end
