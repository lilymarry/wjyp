//
//  SOrderSetOrder.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/6.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SOrderSetOrderSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SOrderSetOrderFailureBlock) (NSError * error);

@interface SOrderSetOrder : NSObject
@property (nonatomic, copy) NSString * address_id;//    地址id    否    文本    1
@property (nonatomic, copy) NSString * order_type;//    order_type    订单类型（ 0:普通 1限量购 2无界商店 3进口馆 4搭配购）
@property (nonatomic, copy) NSString * order_id;//    订单id(订单支付时传)
@property (nonatomic, copy) NSString * collocation;//json(商品id，属性id),搭配购时传； 若无属性id，则不传； 格式：[{"product_id":"0","goods_id":"5"},{"product_id":"1","goods_id":"6"}]
@property (nonatomic, copy) NSString * invoice;//json , 请按顺序传入！！！[{"发票类型id":"1","发票抬头（1->个人，2->公司）":"1","发票抬头名":"name","发票明细":"detail","发票id":"1","识别号”:1111,"是否开发票（1->是，0->否）”:1},{"t_id":"1","rise":"1","rise_name":"name","invoice_detail":"detail","invoice_id":"3",,"recognition”:1111,"is_invoice”:1}]    否
@property (nonatomic, copy) NSString * leave_message;//留言
@property (nonatomic, copy) NSString * goods;//json格式普通商品下单（单商品）参数：[{"属性id":"91","商品id":"43","配送方式id":"11","配送方式类型:"1","快递公司ID":"1","邮费":"1","快递类型":"平邮","描述":" ","相同模板的商品ID":"1,2,3"}][{"product_id":"91","goods_id":"43","tem_id": "4","type_status": 1, "shipping_id": "35","pay": "10","type": "平邮","desc": "满6.000KG满7.00元包邮","same_tem_id": "308,98"}]购物车商品下单（多商品）参数：[{"购物车id":"91","配送方式id":"11","配送方式类型:"1","快递公司ID":"1","邮费":"1","快递类型":"平邮","描述":" ","相同模板的商品ID":"1,2,3"}][{"cate_ids":"91","tem_id": "4","type_status": 1, "shipping_id": "35","pay": "10","type": "平邮","desc": "满6.000KG满7.00元包邮","same_tem_id": "308,98"}]

@property (nonatomic, strong) SOrderSetOrder * data;
@property (nonatomic, copy) NSString * merchant_name;
//@property (nonatomic, copy) NSString * order_id;//": "2",//订单ID
@property (nonatomic, copy) NSString * order_price;//": "99",//订单金额
@property (nonatomic, copy) NSString * is_integral;// "  : 0                   //是否可以使用积分支付（0->不可使用；1->可使用）
@property (nonatomic, copy) NSString * discount;//": "1",//是否可以使用红券 0不可使用  1可以使用
@property (nonatomic, copy) NSString * yellow_discount;//": "1",//是否可以使用黄券 0不可使用  1可以使用
@property (nonatomic, copy) NSString * blue_discount;//": "1",//是否可以使用券 0不可使用  1可以使用
@property (nonatomic, copy) NSString * balance;//": "33.59",//余额
@property (nonatomic, copy) NSString * red_desc;//": ""//红券说明
@property (nonatomic, copy) NSString * yellow_desc;//": ""//黄券说明
@property (nonatomic, copy) NSString * blue_desc;//": ""//蓝券说明
@property (nonatomic, copy) NSString * integral;//": "598.50"       //我的积分
@property (nonatomic, copy) NSString * discount_price;//红券金额
@property (nonatomic, copy) NSString * red_price;   //线下红券金额
@property (nonatomic, copy) NSString * yellow_price;// 黄券金额
@property (nonatomic, copy) NSString * blue_price;// 蓝券金额
@property (nonatomic, copy) NSString * price_desc;//会员优惠描述

@property (nonatomic, assign) BOOL is_order_list; //是否是订单列表进入的

//线下下单  请求参数
@property (nonatomic, copy) NSString *pay_money;
//下单接口返回需要参数
@property (nonatomic, copy) NSString *merchant_id;     //商户ID
@property (nonatomic, copy) NSString *is_pay_password; //是否设置支付密码  0否  1是

@property (nonatomic, copy) NSString *balance_status;   // 是余额支付 2否 1 是
@property (nonatomic, copy) NSString *integration_status;   //是否能用积分支付  1可以  2不可以

@property (nonatomic, copy) NSString * red_return_integral;//赠送积分
@property (nonatomic, copy) NSString * ticket_price;
@property (nonatomic, copy) NSString * ticket_info;

- (void)sOrderSetOrderSuccess:(SOrderSetOrderSuccessBlock)success andFailure:(SOrderSetOrderFailureBlock)failure;


- (void)sOfflineStoreSetOrderSuccess:(SOrderSetOrderSuccessBlock)success andFailure:(SOrderSetOrderFailureBlock)failure;

@end
