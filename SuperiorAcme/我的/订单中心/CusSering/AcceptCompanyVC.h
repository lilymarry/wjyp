//
//  AcceptCompanyVC.h
//  TaoMiShop
//
//  Created by zhaobaofeng on 16/8/9.
//  Copyright © 2016年 zhaobaofeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^AcceptCompanyVC_deliveryBlock) (NSString * delivery_id, NSString * delivery_name);
//3.发票明细
typedef void(^AcceptCompanyVC_typeBlock) (NSString * list);
//4.发票种类
typedef void(^AcceptCompanyVC_invoiceBlock) (NSString * invoice_id, NSString * invoice_type, NSString * express_fee, NSString * tax, NSString * tax_pay, NSString * explain, NSString * t_id);

@interface AcceptCompanyVC : UIViewController
@property (nonatomic, copy) AcceptCompanyVC_deliveryBlock AcceptCompanyVC_delivery;

@property (nonatomic, copy) NSString * type;//1.物流 2.类别 3.发票明细 4.发票种类

//3.发票明细 需要参数
@property (nonatomic, copy) NSString * goods_id;
@property (nonatomic, copy) NSString * t_id;
@property (nonatomic, copy) AcceptCompanyVC_typeBlock AcceptCompanyVC_type;

//4.发票种类 需要参数
//@property (nonatomic, copy) NSString * goods_id;
@property (nonatomic, copy) NSString * num;
@property (nonatomic, copy) NSString * product_id;
@property (nonatomic, assign) BOOL invoice_type_isno;//YES 选择过发票种类了
@property (nonatomic, copy) AcceptCompanyVC_invoiceBlock AcceptCompanyVC_invoice;


/**
 快递单号
 */
@property (nonatomic, strong) NSString *expressOrderSN;

/*
 *记录商品类型,是不是特殊商品,无界商店的商品在计算发票费的时候,需要传递额外的参数
 */
@property (nonatomic, copy) NSString * special_type;

/*
 *用于计算无界商店的商品需要的发票费用的额外传递的参数
 */
@property (nonatomic, copy) NSString * shop_Price;

@end
