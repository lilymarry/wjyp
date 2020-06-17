//
//  SGroupBuyOrderSetOrder.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/7.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SGroupBuyOrderSetOrderSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SGroupBuyOrderSetOrderFailureBlock) (NSError * error);

@interface SGroupBuyOrderSetOrder : NSObject
@property (nonatomic, copy) NSString * address_id;//    地址id    否    文本    1
@property (nonatomic, copy) NSString * goods_num;//    商品数量    否    文本    1
@property (nonatomic, copy) NSString * goods_id;//    商品id    否    文本    1
@property (nonatomic, copy) NSString * product_id;//    商品属性id    否    文本    1
@property (nonatomic, copy) NSString * order_type;//    订单类型 1直接下单 2开团 3 参团    否    文本    1
@property (nonatomic, copy) NSString * group_buy_order_id;//    团购订单id(参团是传)    否    文本    1
@property (nonatomic, copy) NSString * group_buy_id;//    团购ID
@property (nonatomic, copy) NSString * freight;//    运费金额    否    文本    1
@property (nonatomic, copy) NSString * freight_type;//    快递名称
@property (nonatomic, copy) NSString * invoice;//json , 请按顺序传入！！！[{"发票类型id":"1","发票抬头（1->个人，2->公司）":"1","发票抬头名":"name","发票明细":"detail","发票id":"1","识别号”:1111,"是否开发票（1->是，0->否）”:1},{"t_id":"1","rise":"1","rise_name":"name","invoice_detail":"detail","invoice_id":"3",,"recognition”:1111,"is_invoice”:1}]    否
@property (nonatomic, copy) NSString * leave_message;//留言
@property (nonatomic, strong) SGroupBuyOrderSetOrder * data;
//@property (nonatomic, copy) NSString * group_buy_order_id;//": "2",//订单ID
@property (nonatomic, copy) NSString * merchant_name;//":"店铺名称"//店铺名称
@property (nonatomic, copy) NSString * order_price;//": "99",//订单金额
@property (nonatomic, copy) NSString * is_integral;//": "0",//是否可以使用积分 0不可使用  1可以使用
@property (nonatomic, copy) NSString * discount;//": "1",//是否可以使用红券 0不可使用  1可以使用
@property (nonatomic, copy) NSString * yellow_discount;//": "1",//是否可以使用黄券 0不可使用  1可以使用
@property (nonatomic, copy) NSString * blue_discount;//": "1",//是否可以使用券 0不可使用  1可以使用
@property (nonatomic, copy) NSString * balance;//": "33.59",//余额
@property (nonatomic, copy) NSString * red_desc;//": ""//红券说明
@property (nonatomic, copy) NSString * yellow_desc;//": ""//黄券说明
@property (nonatomic, copy) NSString * blue_desc;//": ""//蓝券说明
@property (nonatomic, copy) NSString * integral;//": "598.50"       //我的积分

@property (nonatomic, copy) NSString * red_price;   //线下红券金额
@property (nonatomic, copy) NSString * yellow_price;// 黄券金额
@property (nonatomic, copy) NSString * blue_price;// 蓝券金额
@property (nonatomic, copy) NSString * price_desc;//会员优惠描述

@property (nonatomic, copy) NSString * discount_price;//红券金额

@property (nonatomic, copy) NSString * shipping_id;//物流公司id

@property (nonatomic, copy) NSString * red_return_integral;//物流公司id

@property (nonatomic, copy) NSString * is_coin_pay; //0：不能用银两支付 1：可用银两支付
@property (nonatomic, copy) NSString * chance_num;////银两
- (void)sGroupBuyOrderSetOrderSuccess:(SGroupBuyOrderSetOrderSuccessBlock)success andFailure:(SGroupBuyOrderSetOrderFailureBlock)failure;
@end
