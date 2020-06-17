//
//  SOrderConfirmInvoice.h
//  SuperiorAcme
//
//  Created by GYM on 2018/2/7.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SOrderConfirmInvoice_choiceBlock) (NSString * invoice_type, NSString * t_id, NSString * rise, NSString * rise_name, NSString * invoice_detail, NSString * invoice_id, NSString * recognition, NSString * is_invoice, NSString * express_fee, NSString * tax_pay, NSString * tax, NSString * explain);

@interface SOrderConfirmInvoice : UIViewController
@property (nonatomic, copy) NSString * goods_id;
@property (nonatomic, copy) NSString * num;
@property (nonatomic, copy) NSString * product_id;

@property (nonatomic, copy) SOrderConfirmInvoice_choiceBlock SOrderConfirmInvoice_choice;

@property (nonatomic, copy) NSString * now_invoice_type;//发票类型、顶部按钮文字
@property (nonatomic, copy) NSString * now_t_id;//发票类型id
@property (nonatomic, copy) NSString * now_rise;//发票抬头（1->个人，2->公司）
@property (nonatomic, copy) NSString * now_rise_name;//发票抬头名
@property (nonatomic, copy) NSString * now_invoice_detail;//发票明细
@property (nonatomic, copy) NSString * now_invoice_id;//发票id
@property (nonatomic, copy) NSString * now_recognition;//识别号
@property (nonatomic, copy) NSString * now_is_invoice;//是否开发票
@property (nonatomic, copy) NSString * now_express_fee;//快递费
@property (nonatomic, copy) NSString * now_tax;//税金比例
@property (nonatomic, copy) NSString * now_tax_pay;//税金
@property (nonatomic, copy) NSString * now_explain;//纳税识别号显示内容

/*
 *记录商品类型,是不是特殊商品,无界商店的商品在计算发票费的时候,需要传递额外的参数
 */
@property (nonatomic, copy) NSString * special_type;
/*
 *用于计算无界商店的商品需要的发票费用的额外传递的参数
 */
@property (nonatomic, copy) NSString * shop_Price;
@end
