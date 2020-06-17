//
//  SIntegralBuyOrderShoppingCart.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/18.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SIntegralBuyOrderShoppingCartSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SIntegralBuyOrderShoppingCartFailureBlock) (NSError * error);

@interface SIntegralBuyOrderShoppingCart : NSObject
@property (nonatomic, copy) NSString * merchant_id;//    商家id    否    文本    1
@property (nonatomic, copy) NSString * integralBuy_id;//    一元购id    否    文本    1
@property (nonatomic, copy) NSString * num;//    个数

@property (nonatomic, strong) SIntegralBuyOrderShoppingCart * data;
@property (nonatomic, copy) NSString * address_id;//": "4",//地址id
@property (nonatomic, copy) NSString * receiver;//": "GYM",//收货人
@property (nonatomic, copy) NSString * phone;//": "18600001234",//联系电话
@property (nonatomic, copy) NSString * address;//": "天津市南开区华苑鑫茂科技园",//地址
@property (nonatomic, copy) NSString * province;//": "天津",//省
@property (nonatomic, copy) NSString * city;//": "天津市",//市
@property (nonatomic, copy) NSString * area;//": "南开区",//区
@property (nonatomic, copy) NSString * merchant_name;//": "得一蜂业旗舰店",//店铺名称
@property (nonatomic, copy) NSString * is_default;//" :"1"//是否有默认地址 1是0否
@property (nonatomic, copy) NSString * sum_shop_price;//":"100" //商品总额

@property (nonatomic, copy) NSArray * item;
@property (nonatomic, copy) NSString * welfare;//": 5.696,            // 公益金额
@property (nonatomic, copy) NSString * goods_attr_first;//": "粉,L",         //商品属性
@property (nonatomic, copy) NSString * goods_id;//": "13",//商品id
@property (nonatomic, copy) NSString * goods_name;//": "美式球形爆米花 香甜酥脆到爆 看片好伙伴 休闲零食小吃",//商品名称
@property (nonatomic, copy) NSString * goods_img;//": "http://wjyp.txunda.com/Uploads/Goods/2017-12-01/5a20b9c3370d7.jpg",//商品封面图
//@property (nonatomic, copy) NSString * num;//": "1",//购买数量
@property (nonatomic, copy) NSString * shop_price;//": "26.60",//价格
@property (nonatomic, copy) NSString * order_type;//": "1"//订单类型（ 0:普通 1：团购 2：预购 3：竞拍 4：一元夺宝 5：无界商店 8：线下商城）
@property (nonatomic, copy) NSString * product_id;//":"1"//组和属性id
@property (nonatomic, copy) NSString * is_welfare;//": 1,   // 是否存在公益金额    （1存在，0不存在）
@property (nonatomic, copy) NSString * after_sale_status;//": 1,   // 是否存在售后服务类型    （1存在，0不存在）
@property (nonatomic, copy) NSString * after_sale_type;//": "商家承诺在您签收货物后的7天内，在无人为损坏的情形下，向您提供退货服务。",                      // 售后服务类型
@property (nonatomic, copy) NSString * invoice_status;//": 1,   // 是否可开发票    （1存在，0不存在）
@property (nonatomic, copy) NSString * integrity_a;//":"本产品承诺正品保障"
@property (nonatomic, copy) NSString * integrity_b;//":"本产品承诺正品保障"
@property (nonatomic, copy) NSString * integrity_c;//":"本产品承诺正品保障"

@property (nonatomic, copy) NSString * use_integral; //无界商品 替换shop_price


//下面是自己保存的数据
@property (nonatomic, copy) NSString * send_name;//快递名称
@property (nonatomic, copy) NSString * send_company;//快递公司
@property (nonatomic, copy) NSString * send_price;//快递名称金额
@property (nonatomic, copy) NSString * tem_id;//模板id
@property (nonatomic, copy) NSString * type_status;//配送类型
@property (nonatomic, copy) NSString * shipping_id;//快递公司id
@property (nonatomic, copy) NSString * desc;//
@property (nonatomic, copy) NSString * type;//
@property (nonatomic, copy) NSString * same_tem_id;
@property (nonatomic, copy) NSString * invoice_type;//发票名称
@property (nonatomic, copy) NSString * t_id;//发票类型id
@property (nonatomic, copy) NSString * rise;//发票抬头（1->个人，2->公司）
@property (nonatomic, copy) NSString * rise_name;//发票抬头名
@property (nonatomic, copy) NSString * invoice_detail;//发票明细（文字）
@property (nonatomic, copy) NSString * invoice_id;//发票id
@property (nonatomic, copy) NSString * recognition;//识别号
@property (nonatomic, copy) NSString * is_invoice;//是否开发票
@property (nonatomic, copy) NSString * express_fee;//发票运费
@property (nonatomic, copy) NSString * tax;//税金比例
@property (nonatomic, copy) NSString * tax_pay;//支付税金金额
@property (nonatomic, copy) NSString * explain;//纳税识别号显示内容

/*
 *进口税
 */
@property (nonatomic, copy) NSString * country_tax;//":""//进口税

- (void)sIntegralBuyOrderShoppingCartSuccess:(SIntegralBuyOrderShoppingCartSuccessBlock)success andFailure:(SIntegralBuyOrderShoppingCartFailureBlock)failure;
@end
