//
//  SCarOrderOrderInfo.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SCarOrderOrderInfoSuccessBlock) (NSString * code, NSString * message, id  data);
typedef void(^SCarOrderOrderInfoFailureBlock) (NSError * error);

@interface SCarOrderOrderInfo : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单ID

@property (nonatomic, strong) SCarOrderOrderInfo * data;
//@property (nonatomic, copy) NSString * order_id;//": "1",//订单ID
@property (nonatomic, copy) NSString * car_name;//": "宝马x6 -- 惠安",//车名称
@property (nonatomic, copy) NSString * car_img;//": "http://wjyp.txunda.com/Uploads/CarBuy/2017-09-19/59c0b1324fc8e.png",//图片
@property (nonatomic, copy) NSString * all_price;//": "500000.00",//车全价
@property (nonatomic, copy) NSString * pre_money;//": "99.00",//优惠券金额
@property (nonatomic, copy) NSString * true_pre_money;//": "300.00",//可抵扣金额

@property (nonatomic, copy) NSString * num;//": "1",//购买数量
@property (nonatomic, copy) NSString * discount;//": "0.00",//红券使用比例
@property (nonatomic, copy) NSString * yellow_discount;//": "0.00",//黄券使用比例
@property (nonatomic, copy) NSString * blue_discount;//": "0.00",//蓝券使用比例
@property (nonatomic, copy) NSString * order_price;//": "99.00",//订单金额
@property (nonatomic, copy) NSString * integral;//": "0.00",//使用积分数

@property (nonatomic, copy) NSString * shop_name;//": "",//店铺名称
@property (nonatomic, copy) NSString * lng;//": "0.00",//店铺经度
@property (nonatomic, copy) NSString * lat;//": "0.00",//店铺纬度
@property (nonatomic, copy) NSString * address;//": "吉林省吉林市龙潭区情书路楼台香榭庄园",//店铺地址
@property (nonatomic, copy) NSString * shop_mobile;//": "",//店铺电话
@property (nonatomic, copy) NSString * contact_name;//": "",//联系人
@property (nonatomic, copy) NSString * contact_mobile;//": ""//联系电话

@property (nonatomic, copy) NSString * order_sn;//": "151193125624665",//订单编号
@property (nonatomic, copy) NSString * create_time;//": "2017-11-29 12:54"//下单时间
@property (nonatomic, copy) NSString * pay_type;//": "0",0待支付  1支付宝 2微信  3余额  4积分
@property (nonatomic, copy) NSString * status;//": //可抵扣金额 0待付款  1办手续中，2待评价,4已完成,5已取消

- (void)sCarOrderOrderInfoSuccess:(SCarOrderOrderInfoSuccessBlock)success andFailure:(SCarOrderOrderInfoFailureBlock)failure;
@end
