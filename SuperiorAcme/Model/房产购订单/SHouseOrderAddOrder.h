//
//  SHouseOrderAddOrder.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/30.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SHouseOrderAddOrderSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SHouseOrderAddOrderFailureBlock) (NSError * error);

@interface SHouseOrderAddOrder : NSObject
@property (nonatomic, copy) NSString * style_id;//    户型ID    否    文本    1
@property (nonatomic, copy) NSString * num;//    购买数量
@property (nonatomic, copy) NSString * order_id;

@property (nonatomic, strong) SHouseOrderAddOrder * data;
//@property (nonatomic, copy) NSString * order_id;//": "2",//订单ID
@property (nonatomic, copy) NSString * order_price;//": "99",//订单金额
@property (nonatomic, copy) NSString * discount;//": "1",//是否可以使用红券 0不可使用  1可以使用
@property (nonatomic, copy) NSString * yellow_discount;//": "1",//是否可以使用黄券 0不可使用  1可以使用
@property (nonatomic, copy) NSString * blue_discount;//": "1",//是否可以使用券 0不可使用  1可以使用
@property (nonatomic, copy) NSString * is_integral;//": "0",//是否可以使用积分 0不可使用  1可以使用
@property (nonatomic, copy) NSString * balance;//": "33.59",//余额
@property (nonatomic, copy) NSString * integral;//": "0.00"//积分
@property (nonatomic, copy) NSString * red_desc;//": ""//红券说明
@property (nonatomic, copy) NSString * yellow_desc;//": ""//黄券说明
@property (nonatomic, copy) NSString * blue_desc;//": ""//蓝券说明

@property (nonatomic, copy) NSString * red_price;   //线下红券金额
@property (nonatomic, copy) NSString * yellow_price;// 黄券金额
@property (nonatomic, copy) NSString * blue_price;// 蓝券金额
@property (nonatomic, copy) NSString * price_desc;//会员优惠描述

- (void)sHouseOrderAddOrderSuccess:(SHouseOrderAddOrderSuccessBlock)success andFailure:(SHouseOrderAddOrderFailureBlock)failure;
@end
