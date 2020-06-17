//
//  SHouseOrderOrderList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/30.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SHouseOrderOrderListSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SHouseOrderOrderListFailureBlock) (NSError * error);

@interface SHouseOrderOrderList : NSObject
@property (nonatomic, copy) NSString * type;//    类型：type 1全部 2待付款 3办手续中 4待评价    否    文本    1
@property (nonatomic, copy) NSString * p;//

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * order_id;//": "7",//订单ID
@property (nonatomic, copy) NSString * house_name;//": "棠颂别墅",//楼盘名称
@property (nonatomic, copy) NSString * house_style_img;//": "http://wjyp.txunda.com/Uploads/HouseStyle/2017-11-27/5a1bb5e124ae1.png",//户型图
@property (nonatomic, copy) NSString * lng;//": "117.188180",//经度
@property (nonatomic, copy) NSString * lat;//": "39.151049",//纬度
@property (nonatomic, copy) NSString * style_name;//": "棠颂别墅 三室一厅",//户型名称
@property (nonatomic, copy) NSString * tags;//": "大户型,在售,独栋",//标签
@property (nonatomic, copy) NSString * pre_money;//": "99.00",//代金券金额
@property (nonatomic, copy) NSString * true_pre_money;//
@property (nonatomic, copy) NSString * num;//": "1",//购买数量
@property (nonatomic, copy) NSString * goods_price;//": "99.00",//商品价格
@property (nonatomic, copy) NSString * order_price;//": "99.00",//订单金额
@property (nonatomic, copy) NSString * status;//": "1"//0待付款  1办手续中，2待评价,4已完成,5已取消

- (void)sHouseOrderOrderListSuccess:(SHouseOrderOrderListSuccessBlock)success andFailure:(SHouseOrderOrderListFailureBlock)failure;
@end
