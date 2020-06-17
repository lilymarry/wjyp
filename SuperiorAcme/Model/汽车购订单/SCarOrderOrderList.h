//
//  SCarOrderOrderList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SCarOrderOrderListSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SCarOrderOrderListFailureBlock) (NSError * error);

@interface SCarOrderOrderList : NSObject
@property (nonatomic, copy) NSString * type;//    类型：type 1全部 2待付款 3办手续中 4待评价    否    文本    1
@property (nonatomic, copy) NSString * p;//    分页参数

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * order_id;//": "12",//订单ID
@property (nonatomic, copy) NSString * car_img;//": "http://wjyp.txunda.com/Uploads/CarBuy/2017-09-19/59c0b1324fc8e.png",//车图片
@property (nonatomic, copy) NSString * car_name;//": "宝马x6 -- 惠安",//车名称
@property (nonatomic, copy) NSString * pre_money;//": "99.00",//代金券金额
@property (nonatomic, copy) NSString * num;//": "1",//购买数量
@property (nonatomic, copy) NSString * goods_price;//": "99.00",//总金额
@property (nonatomic, copy) NSString * order_price;//": "99.00",//订单总金额
@property (nonatomic, copy) NSString * integral;//": "0.00",//使用积分
@property (nonatomic, copy) NSString * shop_name;//": "",//店铺名称
@property (nonatomic, copy) NSString * lng;//": "0.00",//经度
@property (nonatomic, copy) NSString * lat;//": "0.00",//纬度
@property (nonatomic, copy) NSString * pay_type;//": "0",//支付方式0待支付  1支付宝 2微信  3余额  4积分
@property (nonatomic, copy) NSString * true_pre_money;//": "300.00"//可抵扣金额
@property (nonatomic, copy) NSString * status;//": //可抵扣金额 0待付款  1办手续中，2待评价,4已完成,5已取消


- (void)sCarOrderOrderListSuccess:(SCarOrderOrderListSuccessBlock)success andFailure:(SCarOrderOrderListFailureBlock)failure;
@end
