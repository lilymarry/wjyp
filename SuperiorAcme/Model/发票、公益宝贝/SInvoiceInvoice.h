//
//  SInvoiceInvoice.h
//  SuperiorAcme
//
//  Created by GYM on 2018/2/9.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SInvoiceInvoiceSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SInvoiceInvoiceFailureBlock) (NSError * error);

@interface SInvoiceInvoice : NSObject
@property (nonatomic, copy) NSString * goods;//    json,商品id goods_id，属性id（没有为0）product_id，数量 num [{"goods_id":"6","num":"1","product_id":"6"}]

@property (nonatomic, strong) SInvoiceInvoice * data;
@property (nonatomic, copy) NSString * explain;//": "如购买方为企业，有税号的非企业单位和个体工商户，请填写\"纳税人识别号\""  ////纳税识别号显示内容

@property (nonatomic, copy) NSArray * list;
@property (nonatomic, copy) NSString * invoice_id;//": "1",            //发票id
@property (nonatomic, copy) NSString * t_id;//": "1",            //发票类型id
@property (nonatomic, copy) NSString * invoice_type;//": "测试1",     // 发票种类名
@property (nonatomic, copy) NSString * express_fee;//": "2",             // 发票运费
@property (nonatomic, copy) NSString * tax;//": "3",                      //税金比例
@property (nonatomic, copy) NSString * tax_pay;//": 3.3              //支付税金金额


/*
 *记录商品类型,是不是特殊商品,无界商店的商品在计算发票费的时候,需要传递额外的参数
 */
@property (nonatomic, copy) NSString * special_typel;
/*
 *无界商店需要穿的额外的参数,用于计算开发票的钱
 */
@property (nonatomic, copy) NSString * shop_price;

- (void)sInvoiceInvoiceSuccess:(SInvoiceInvoiceSuccessBlock)success andFailure:(SInvoiceInvoiceFailureBlock)failure;
@end
