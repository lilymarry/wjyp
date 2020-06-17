//
//  SHouseOrderOrderInfo.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/30.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SHouseOrderOrderInfoSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SHouseOrderOrderInfoFailureBlock) (NSError * error);

@interface SHouseOrderOrderInfo : NSObject
@property (nonatomic, copy) NSString * order_id;//    订单ID

@property (nonatomic, strong) SHouseOrderOrderInfo * data;
//@property (nonatomic, copy) NSString * order_id;//": "7",//订单ID
@property (nonatomic, copy) NSString * order_sn;//": "151202722676758",//订单编号
@property (nonatomic, copy) NSString * house_name;//": "棠颂别墅",//楼盘名称
@property (nonatomic, copy) NSString * sell_address;//";: "天晶石北辰区董总快速",//楼盘地址
@property (nonatomic, copy) NSString * link_man;//": "",//联系人
@property (nonatomic, copy) NSString * link_phone;//": "0351-5263254",//联系电话
@property (nonatomic, copy) NSString * lng;//": "117.188180",//经度
@property (nonatomic, copy) NSString * lat;//": "39.151049",//纬度
@property (nonatomic, copy) NSString * style_name;//": "棠颂别墅 三室一厅",//户型名称
@property (nonatomic, copy) NSString * house_style_img;//": "http://wjyp.txunda.com/Uploads/HouseStyle/2017-11-27/5a1bb5e124ae1.png",//户型图片
@property (nonatomic, copy) NSString * tags;//": "大户型,在售,独栋",//户型标签
@property (nonatomic, copy) NSString * one_price;//": "12000.01",//房价
@property (nonatomic, copy) NSString * pre_money;//": "99.00",//代金券金额
@property (nonatomic, copy) NSString * true_pre_money;//": "500.00",//抵扣金额
@property (nonatomic, copy) NSString * num;//": "1",//购买数量
@property (nonatomic, copy) NSString * discount;//": "0.00",//红券使用比例
@property (nonatomic, copy) NSString * yellow_discount;//": "0.00",//黄券使用比例
@property (nonatomic, copy) NSString * blue_discount;//": "0.00",//蓝券使用比例
@property (nonatomic, copy) NSString * order_price;//": "99.00",//订单金额
@property (nonatomic, copy) NSString * integral;//": "0.00",//使用积分数
@property (nonatomic, copy) NSString * create_time;//": "2017-11-29 12:54"//下单时间
@property (nonatomic, copy) NSString * pay_type;//": "0",0待支付  1支付宝 2微信  3余额  4积分
@property (nonatomic, copy) NSString * status;//": //可抵扣金额 0待付款  1办手续中，2待评价,4已完成,5已取消
@property (nonatomic, copy) NSString * all_price;

- (void)sHouseOrderOrderInfoSuccess:(SHouseOrderOrderInfoSuccessBlock)success andFailure:(SHouseOrderOrderInfoFailureBlock)failure;
@end
