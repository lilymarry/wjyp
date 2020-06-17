//
//  SLimitBuyOrderSetOrder.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SLimitBuyOrderSetOrderSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SLimitBuyOrderSetOrderFailureBlock) (NSError * error);

@interface SLimitBuyOrderSetOrder : NSObject
@property (nonatomic, copy) NSString * limit_buy_id;//    限量购id    否    文本    1
@property (nonatomic, copy) NSString * goods_id;//    商品id    否    文本    1
@property (nonatomic, copy) NSString * goods_num;//    购买数量    否    文本    1
@property (nonatomic, copy) NSString * product_id;//    商品属性id    否    文本    1
@property (nonatomic, copy) NSString * address_id;//    地址id    否    文本    1
@property (nonatomic, copy) NSString * limit_buy_order_id;//    限量购订单id(订单列表支付时传)

@property (nonatomic, strong) SLimitBuyOrderSetOrder * data;
//@property (nonatomic, copy) NSString * limit_buy_order_id;//": "2",//订单ID
@property (nonatomic, copy) NSString * merchant_name;//":"店铺名称"//店铺名称
@property (nonatomic, copy) NSString * order_price;//": "99",//订单金额
@property (nonatomic, copy) NSString * discount;//": "1",//是否可以使用红券 0不可使用  1可以使用
@property (nonatomic, copy) NSString * yellow_discount;//": "1",//是否可以使用黄券 0不可使用  1可以使用
@property (nonatomic, copy) NSString * blue_discount;//": "1",//是否可以使用券 0不可使用  1可以使用
@property (nonatomic, copy) NSString * balance;//": "33.59",//余额
@property (nonatomic, copy) NSString * red_desc;//": ""//红券说明
@property (nonatomic, copy) NSString * yellow_desc;//": ""//黄券说明
@property (nonatomic, copy) NSString * blue_desc;//": ""//蓝券说明

- (void)sLimitBuyOrderSetOrderSuccess:(SLimitBuyOrderSetOrderSuccessBlock)success andFailure:(SLimitBuyOrderSetOrderFailureBlock)failure;
@end
