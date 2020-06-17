//
//  SIntegralOrderOrderList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SIntegralOrderOrderListSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SIntegralOrderOrderListFailureBlock) (NSError * error);

@interface SIntegralOrderOrderList : NSObject
@property (nonatomic, copy) NSString * order_status;//    订单状态（'0': '待付款‘ ； '1': '待发货' ； '2': '待收货' ；'3': '待评价'；'4': '已完成；‘5’：取消订单; '8': 已付款 ；'10':'进行中'；11：‘已揭晓’；12：已中奖；13：未中奖） 默认9（全部）    否    文本    1
@property (nonatomic, copy) NSString * p;//    分页参数

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * order_id;//": "108",             //订单id
//@property (nonatomic, copy) NSString * order_status;//": "0",          //订单状态
@property (nonatomic, copy) NSString * merchant_name;//": "得一蜂业旗舰店",     //商家名称
@property (nonatomic, copy) NSString * order_price;//": 36,                 //订单总额
@property (nonatomic, copy) NSString * time_num;//": "000000001",          //期号
@property (nonatomic, copy) NSString * goods_id;//": "12",         //商品id
@property (nonatomic, copy) NSString * product_id;//
@property (nonatomic, copy) NSString * goods_num;//": "6",       //商品数量
@property (nonatomic, copy) NSString * add_num;//": 19,          //购买人数
@property (nonatomic, copy) NSString * all_num;//": 19,          //总人数
@property (nonatomic, copy) NSString * person_status;//": 0,
@property (nonatomic, copy) NSString * integral_id;//": "000000001",
@property (nonatomic, copy) NSString * sum_price;//": "9999999"

@property (nonatomic, strong) SIntegralOrderOrderList * order_goods;
@property (nonatomic, copy) NSString * shop_price;//": "6.00",                //商品单价
@property (nonatomic, copy) NSString * pic;//": "http://wjyp.txunda.com/Uploads/Goods/2017-12-01/5a20b882f1e70.jpg",       //图片
//@property (nonatomic, copy) NSString * order_id;//": "108",                             //订单id
@property (nonatomic, copy) NSString * goods_name;//": "香脆小麻花 50根/100g根/200根多规格可选 就是酥脆好吃",          //商品名
@property (nonatomic, copy) NSString * goods_attr;//": ""              //属性

- (void)sIntegralOrderOrderListSuccess:(SIntegralOrderOrderListSuccessBlock)success andFailure:(SIntegralOrderOrderListFailureBlock)failure;
@end
