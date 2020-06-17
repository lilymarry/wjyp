//
//  SIntegralOrderDetails.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SIntegralOrderDetailsSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SIntegralOrderDetailsFailureBlock) (NSError * error);

@interface SIntegralOrderDetails : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单id

@property (nonatomic, strong) SIntegralOrderDetails * data;
@property (nonatomic, copy) NSString * integral_num;//": "24.00",         // 所需积分
@property (nonatomic, copy) NSString * balance_num;//": "18.00",        // 所需余额
@property (nonatomic, copy) NSString * discount;//": "0.00",                  // 所需红券
@property (nonatomic, copy) NSString * yellow_discount;//": "0.00",      // 所需黄券
@property (nonatomic, copy) NSString * blue_discount;//": "0.00",        // 所需蓝券
@property (nonatomic, copy) NSString * merchant_id;//": "1",              // 商家id
@property (nonatomic, copy) NSString * merchant_name;//": "得一蜂业旗舰店",
@property (nonatomic, copy) NSString * order_status;//": "0",
@property (nonatomic, copy) NSString * order_sn;//": "151272972030052",                       // 期号
@property (nonatomic, copy) NSString * goods_num;//": "3",                                              // 总数

@property (nonatomic, strong) SIntegralOrderDetails * list;
@property (nonatomic, copy) NSString * order_goods_id;//":"1" //订单商品id
@property (nonatomic, copy) NSString * goods_name;//": "香脆小麻花 50根/100g根/200根多规格可选 就是酥脆好吃",          //商品名
@property (nonatomic, copy) NSString * goods_img;//": "http://wjyp.txunda.com/Uploads/Goods/2017-12-01/5a20b882f1e70.jpg", //商品图
//@property (nonatomic, copy) NSString * number;//": "151272738",                    //我的团号
@property (nonatomic, copy) NSString * attr;//": "重量:1000g;口味:辣"                 //属性
@property (nonatomic, copy) NSString * after_type;//":"0" //商品退货状态 0正常 1退货 2退款成功
@property (nonatomic, copy) NSString * back_apply_id;//  订单详情每个商品   售后id
@property (nonatomic, copy) NSString * is_sales;//  订单详情每个商品   商家是否同意退货，（0不同意 1同意）
@property (nonatomic, copy) NSArray * number;
@property (nonatomic, copy) NSString * number_list;//": "151297322"

- (void)sIntegralOrderDetailsSuccess:(SIntegralOrderDetailsSuccessBlock)success andFailure:(SIntegralOrderDetailsFailureBlock)failure;
@end
