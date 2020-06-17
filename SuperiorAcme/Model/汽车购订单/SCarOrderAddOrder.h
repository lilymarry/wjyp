//
//  SCarOrderAddOrder.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/28.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SCarOrderAddOrderSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SCarOrderAddOrderFailureBlock) (NSError * error);

@interface SCarOrderAddOrder : NSObject
@property (nonatomic, copy) NSString * car_id;//    汽车购ID    否    文本    1
@property (nonatomic, copy) NSString * num;//    购买数量
@property (nonatomic, copy) NSString * order_id;//": "2",//订单ID
    
@property (nonatomic, strong) SCarOrderAddOrder * data;
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
@property (nonatomic, copy) NSString * price_desc;//会员优惠描述

@property (nonatomic, copy) NSString * red_price;   //线下红券金额
@property (nonatomic, copy) NSString * yellow_price;// 黄券金额
@property (nonatomic, copy) NSString * blue_price;// 蓝券金额


- (void)sCarOrderAddOrderSuccess:(SCarOrderAddOrderSuccessBlock)success andFailure:(SCarOrderAddOrderFailureBlock)failure;
@end
