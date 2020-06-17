//
//  SOfflineStoreOrderListModel.h
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/7/30.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SOfflineStoreOrderListModelSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SOfflineStoreOrderListModelFailureBlock) (NSError * error);

@interface SOfflineStoreOrderListModel : NSObject
/*
 "order_id": "33",//订单ID
 "order_sn": "153248735848611",//订单编号
 "merchant_id": "38",//商家ID
 "merchant_name": "达令商城",//商家名称
 "create_time": "2018-07-25 10:55:58",//下单时间
 "pay_time": "2018-07-25 10:55:58",//支付时间（如果  pay_status=0  不显示支付时间）
 "order_price": "0.10",//订单金额
 "pay_status": "1",//支付状态   0未支付   1已支付
 "pay_type":"1余额 2微信 3支付宝 4 积分支付"
 "status": "0"//0正常 5取消订单
 */
@property (nonatomic, copy) NSString * order_id;//订单id
@property (nonatomic, copy) NSString * order_sn;//订单编号
@property (nonatomic, copy) NSString * merchant_id;//店铺id
@property (nonatomic, copy) NSString * merchant_name;//店铺名字
@property (nonatomic, copy) NSString * create_time;//下单时间
@property (nonatomic, copy) NSString * pay_time;//支付时间
@property (nonatomic, copy) NSString * order_price;//订单金额
@property (nonatomic, copy) NSString * pay_status;//支付状态
@property (nonatomic, copy) NSString * pay_type;  //支付方式
@property (nonatomic, copy) NSString * status;//订单操作状态
@property (nonatomic, assign) NSInteger common_status; //评价状态

@property (nonatomic, copy) NSString * p;//分页


- (void)sOfflineStoreOrderListSuccess:(SOfflineStoreOrderListModelSuccessBlock)success andFailure:(SOfflineStoreOrderListModelFailureBlock)failure;
@end
