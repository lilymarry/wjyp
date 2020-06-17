//
//  SOrderOrderList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/6.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SOrderOrderListSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SOrderOrderListFailureBlock) (NSError * error);

@interface SOrderOrderList : NSObject
@property (nonatomic, copy) NSString * order_status;//    订单状态（'0': '待支付‘ ； '1': '待发货' ； '2': '待收货' ；'3': '待评价'；'4': '已完成） 默认全部    是    文本    0
@property (nonatomic, copy) NSString * order_type;//    购买渠道（0:普通 1：团购 2：预购 3：竞拍 4：一元夺宝 5：无界商店 8：线下商城）
@property (nonatomic, copy) NSString * p;

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * order_id;//": "23",         //订单id
//@property (nonatomic, copy) NSString * order_status;//": "0",         //订单状态
@property (nonatomic, copy) NSString * merchant_name;//": "",     //店铺名称
@property (nonatomic, copy) NSString * merchant_id;//店铺id
@property (nonatomic, copy) NSString * order_price;//": "0.00",      //订单总价
@property (nonatomic, copy) NSString * freight;//"   // 运费;
//
@property (nonatomic, copy) NSArray * order_goods;
@property (nonatomic, copy) NSString * goods_name;//": "自制DIY微波爆米花 随时自己来一包 就是香脆",
@property (nonatomic, copy) NSString * shop_price;//": "19.90",
@property (nonatomic, copy) NSString * goods_num;//": "1",
@property (nonatomic, copy) NSString * goods_attr;//": ""
@property (nonatomic, copy) NSString * pic;//
@property (nonatomic, copy) NSString * return_integral;

@property (nonatomic, copy) NSString * shop_id;//
@property (nonatomic, copy) NSString * shop_name;

@property (nonatomic, copy) NSString * is_active; //专区商品
@property (nonatomic, copy) NSString * apply_id; //订单显示去寄售条件（order_type=7 and apply_id=0 and order_status=4或3）
@property (nonatomic, copy) NSString * goods_id; //订单显示去寄售条件（order_type=7 and apply_id=0 and order_status=4或3）
- (void)sOrderOrderListSuccess:(SOrderOrderListSuccessBlock)success andFailure:(SOrderOrderListFailureBlock)failure;
@end
