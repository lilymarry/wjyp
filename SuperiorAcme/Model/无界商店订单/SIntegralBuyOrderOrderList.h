//
//  SIntegralBuyOrderOrderList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/18.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SIntegralBuyOrderOrderListSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SIntegralBuyOrderOrderListFailureBlock) (NSError * error);

@interface SIntegralBuyOrderOrderList : NSObject
@property (nonatomic, copy) NSString * order_status;//    订单状态（'0': '待付款‘ ； '1': '待发货' ； '2': '待收货' ；'3': '待评价'；'4': '已完成；‘5’：取消订单） 默认9（全部）    否    文本    9
@property (nonatomic, copy) NSString * p;//    分页参数

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * order_id;//": "108",             //订单id
//@property (nonatomic, copy) NSString * order_status;//": "0",          //订单状态
@property (nonatomic, copy) NSString * merchant_name;//": "得一蜂业旗舰店",     //商家名称
@property (nonatomic, copy) NSString * order_price;//": 36,                 //订单总额
@property (nonatomic, copy) NSString * goods_id;//": "12",         //商品id
@property (nonatomic, copy) NSString * goods_num;//": "6",       //商品数量
@property (nonatomic, copy) NSString * freight;//"   // 运费;

@property (nonatomic, copy) NSArray * order_goods;
@property (nonatomic, copy) NSString * shop_price;//": "6.00",                //商品单价
@property (nonatomic, copy) NSString * pic;//": "http://wjyp.txunda.com/Uploads/Goods/2017-12-01/5a20b882f1e70.jpg",       //图片
//@property (nonatomic, copy) NSString * order_id;//": "108",                             //订单id
@property (nonatomic, copy) NSString * goods_name;//": "香脆小麻花 50根/100g根/200根多规格可选 就是酥脆好吃",          //商品名

//新增商品规格
@property (nonatomic, copy) NSString *goods_attr;
//return_integral
@property (nonatomic, copy) NSString *return_integral;

- (void)sIntegralBuyOrderOrderListSuccess:(SIntegralBuyOrderOrderListSuccessBlock)success andFailure:(SIntegralBuyOrderOrderListFailureBlock)failure;
@end
