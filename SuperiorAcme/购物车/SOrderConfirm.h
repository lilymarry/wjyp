//
//  SOrderConfirm.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOrderConfirm : UIViewController

/* 普通商品special_type == nil
 * 普通商品、限量购、进口馆、票券区
 */
@property (nonatomic, copy) NSString * cart_id;//购物车id 多个用','开
@property (nonatomic, copy) NSString * merchant_id;//商家id
@property (nonatomic, copy) NSString * goods_Json;//json(商品id，属性id) 1.立即购买:goods_id + product_id 2.搭配购:goods_Json
@property (nonatomic, copy) NSString * goods_id;//    商品id(直接购买时传)    否    文本    1
@property (nonatomic, copy) NSString * product_id;
@property (nonatomic, copy) NSString * num;//    数量(直接购买时传)    否    文本    1

/* 特殊商品 special_type == 对应文字
 * 拼单购、无界预购、积分抽奖、比价购、无界商店  寄售管理
 */
@property (nonatomic, copy) NSString * special_type;

@property (nonatomic, copy) NSString * special_type_sub;//1直接购买 2拼单(开团) 3拼单(参团)
@property (nonatomic, copy) NSString * group_buy_id;//团购id(直接购买、开团、拼团都要传)
@property (nonatomic, copy) NSString * group_buy_order_id;//团购订单id(参团时传)

@property (nonatomic, copy) NSString * pre_id;//无界预购id
@property (nonatomic, copy) NSString * integral_id;//    一元购id

@property (nonatomic, copy) NSString * auction_id;//    竞拍id
@property (nonatomic, copy) NSString * order_id;//   竞拍付尾款需要传   互清库存
@property (nonatomic, assign) BOOL auction_isno;//NO竞拍 YES一口价

@property (nonatomic, copy) NSString * integralBuy_id;//无界商店id

@property (nonatomic, copy) NSString * shipping_id;//快递公司id

@property (nonatomic, copy) NSString * giftGoods_id;

@end
