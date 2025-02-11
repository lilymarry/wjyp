//
//  SAuctionOrderSetOrder.h
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SAuctionOrderSetOrderSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SAuctionOrderSetOrderFailureBlock) (NSError * error);

@interface SAuctionOrderSetOrder : NSObject
@property (nonatomic, copy) NSString * address_id;//    地址id（立即购买需传）    否    文本    1
@property (nonatomic, copy) NSString * auction_id;//    竞拍id(直接购买时传)（一口价）
@property (nonatomic, copy) NSString * buy_type;//    购买类型：0->一口价；1->竞拍    否    文本    1
@property (nonatomic, copy) NSString * bid;//    竞拍出价（当buy_type=1时需传）    否    文本    1
@property (nonatomic, copy) NSString * order_id;//    订单id(我的订单->付款时需传)
@property (nonatomic, copy) NSString * freight;//    运费金额    否    文本    1
@property (nonatomic, copy) NSString * freight_type;//    快递名称

@property (nonatomic, strong) SAuctionOrderSetOrder * data;
//@property (nonatomic, copy) NSString * order_id;//": "2",//订单ID
@property (nonatomic, copy) NSString * order_price;//": "99",//订单金额
@property (nonatomic, copy) NSString * merchant_name;//" : "商家名称"                //商家名称
@property (nonatomic, copy) NSString * is_integral;//": "0",//是否可以使用积分 0不可使用  1可以使用
@property (nonatomic, copy) NSString * discount;//t": "1",//是否可以使用红券 0不可使用  1可以使用
@property (nonatomic, copy) NSString * yellow_discount;//": "1",//是否可以使用黄券 0不可使用  1可以使用
@property (nonatomic, copy) NSString * blue_discount;//": "1",//是否可以使用券 0不可使用  1可以使用
@property (nonatomic, copy) NSString * balance;//": "33.59",//余额
@property (nonatomic, copy) NSString * red_desc;//": ""//红券说明
@property (nonatomic, copy) NSString * yellow_desc;//": ""//黄券说明
@property (nonatomic, copy) NSString * blue_desc;//": ""//蓝券说明
@property (nonatomic, copy) NSString * integral;//": "598.50"       //我的积分

@property (nonatomic, copy) NSString * red_price;   //线下红券金额
@property (nonatomic, copy) NSString * yellow_price;// 黄券金额
@property (nonatomic, copy) NSString * blue_price;// 蓝券金额
@property (nonatomic, copy) NSString * price_desc;//会员优惠描述
@property (nonatomic, copy) NSString * red_return_integral;//会员优惠描述
- (void)sAuctionOrderSetOrderSuccess:(SAuctionOrderSetOrderSuccessBlock)success andFailure:(SAuctionOrderSetOrderFailureBlock)failure;
@end
