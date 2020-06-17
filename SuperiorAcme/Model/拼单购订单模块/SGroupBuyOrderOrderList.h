//
//  SGroupBuyOrderOrderList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SGroupBuyOrderOrderListSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SGroupBuyOrderOrderListFailureBlock) (NSError * error);

@interface SGroupBuyOrderOrderList : NSObject
@property (nonatomic, copy) NSString * order_status;//    订单状态（'0': '待付款‘ ； '1': '待成团' ； '2': '待发货' ；'3': '待收货'；'4': '待评价 5 已完成 6取消 9全部  7待抽奖  10未中奖 否    文本    1
@property (nonatomic, copy) NSString * p;//    分页参数

@property (nonatomic, copy) NSArray * data;

/*
 *添加体验拼单商品提示
 */
//"group_type": "类型 1试用品拼单 2常规拼单",
@property (nonatomic, copy) NSString * group_type;
@property (nonatomic, copy) NSString * group_buy_order_id;//": "23",         //订单id
@property (nonatomic, copy) NSString * group_buy_id;//":10 //团购id
//@property (nonatomic, copy) NSString * order_status;//": "0", //订单状态（0待付款1待成团 2 待发货' 3 待收货4 '待评价 5 已完成  6取消
@property (nonatomic, copy) NSString * merchant_name;//": "",     //店铺名称
@property (nonatomic, copy) NSString * order_price;//": "0.00",      //订单总价
@property (nonatomic, copy) NSString * order_type;//": "2"," //订单类型 1直接下单 2拼团 3参团
@property (nonatomic, copy) NSString * p_id;//": "0"," //开团订单id
@property (nonatomic, copy) NSString * freight;//"   // 运费;

@property (nonatomic, copy) NSArray * order_goods;
@property (nonatomic, copy) NSString * order_id;//": "23",
@property (nonatomic, copy) NSString * goods_name;//": "自制DIY微波爆米花 随时自己来一包 就是香脆",
//@property (nonatomic, copy) NSString * merchant_name;//": "得一蜂业旗舰店",
@property (nonatomic, copy) NSString * shop_price;//": "19.90",             //售价
@property (nonatomic, copy) NSString * goods_num;//": "0",                  //数量
@property (nonatomic, copy) NSString * goods_attr;//": ""                      //属性
@property (nonatomic, copy) NSString * pic;//":"/Uploads/Merchant/2016-11-11/582560c85734c.jpg"     图片
@property (nonatomic, copy) NSString * return_integral;//":""返回积分数

- (void)sGroupBuyOrderOrderListSuccess:(SGroupBuyOrderOrderListSuccessBlock)success andFailure:(SGroupBuyOrderOrderListFailureBlock)failure;
@end
