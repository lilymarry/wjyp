//
//  SLimitBuyOrderOrderList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SLimitBuyOrderOrderListSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SLimitBuyOrderOrderListFailureBlock) (NSError * error);

@interface SLimitBuyOrderOrderList : NSObject
@property (nonatomic, copy) NSString * order_status;//    订单状态 0待支付1待发货2待收货3待评价4已完成 5已取消 9全部    否    文本    1
@property (nonatomic, copy) NSString * p;//    分页

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * limit_buy_order_id;//": "23",         //订单id
@property (nonatomic, copy) NSString * limit_order_id;//":10 //限量购id
//@property (nonatomic, copy) NSString * order_status;//": "0", //订单状态 0待支付1待发货2待收货3待评价4已完成 5已取消
@property (nonatomic, copy) NSString * merchant_name;//": "",     //店铺名称
@property (nonatomic, copy) NSString * order_price;//": "0.00",      //订单总价
@property (nonatomic, copy) NSString * order_type;//": "2"," //订单类型 1直接下单 2拼团 3参团
@property (nonatomic, copy) NSString * p_id;//": "0"," //开团订单id

@property (nonatomic, copy) NSArray * order_goods;
//@property (nonatomic, copy) NSString * limit_order_id;//": "23",
@property (nonatomic, copy) NSString * goods_name;//": "自制DIY微波爆米花 随时自己来一包 就是香脆",
//@property (nonatomic, copy) NSString * merchant_name;//": "得一蜂业旗舰店",
@property (nonatomic, copy) NSString * shop_price;//": "19.90",             //售价
@property (nonatomic, copy) NSString * goods_num;//": "0",                  //数量
@property (nonatomic, copy) NSString * goods_attr;//": ""                      //属性
@property (nonatomic, copy) NSString * pic;//":"/Uploads/Merchant/2016-11-11/582560c85734c.jpg"     图片

- (void)sLimitBuyOrderOrderListSuccess:(SLimitBuyOrderOrderListSuccessBlock)success andFailure:(SLimitBuyOrderOrderListFailureBlock)failure;
@end
