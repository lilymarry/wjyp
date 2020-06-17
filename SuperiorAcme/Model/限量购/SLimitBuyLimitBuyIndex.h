//
//  SLimitBuyLimitBuyIndex.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SLimitBuyLimitBuyIndexSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SLimitBuyLimitBuyIndexFailureBlock) (NSError * error);

@interface SLimitBuyLimitBuyIndex : NSObject
@property (nonatomic, copy) NSString * stage_id;//场次id (默认是当前时间所在场次)
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, strong) SLimitBuyLimitBuyIndex * data;
@property (nonatomic, copy) NSString * end_time;//"18:00",//本场结束时间

//时间场次列表
@property (nonatomic, copy) NSArray * stage_list;
//@property (nonatomic, copy) NSString * stage_id;//"1",
@property (nonatomic, copy) NSString * stage_name;//"早场",
@property (nonatomic, copy) NSString * start_time;//"9:00",
//@property (nonatomic, copy) NSString * end_time;//"12:00",
@property (nonatomic, copy) NSString * status;//"已结束"

@property (nonatomic, strong) SLimitBuyLimitBuyIndex * ads;
@property (nonatomic, copy) NSString * ads_id;//"13",
@property (nonatomic, copy) NSString * picture;//"http://wjyp.txunda.com/Uploads/Ads/2017-08-16/5993eef6c4764.jpg",
@property (nonatomic, copy) NSString * desc;//"adasnsansa",
@property (nonatomic, copy) NSString * merchant_id;//”：“店铺id”
@property (nonatomic, copy) NSString * goods_id;//”：“商品id”
@property (nonatomic, copy) NSString * href;//": "广告链接"

@property (nonatomic, copy) NSArray * limitBuyList;
@property (nonatomic, copy) NSString * limit_buy_id;//"限量购id",
@property (nonatomic, copy) NSString * limit_price;//"限量购价格",
@property (nonatomic, copy) NSString * limit_store;//"库存",
@property (nonatomic, copy) NSString * limit_num;//"每人限购数量",
@property (nonatomic, copy) NSString * integral;//"积分",
@property (nonatomic, copy) NSString * sell_num;//"已售",
@property (nonatomic, copy) NSString * market_price;// "原价",
@property (nonatomic, copy) NSString * goods_name;//"商品名称",
@property (nonatomic, copy) NSString * goods_img;//"商品图片",
@property (nonatomic, copy) NSString * country_id;//"国家id",
@property (nonatomic, copy) NSString * ticket_buy_id;//"票券id",
@property (nonatomic, copy) NSString * country_logo;//"国家logo",
@property (nonatomic, copy) NSString * ticket_buy_discount;//"可使用购物券折扣率"
@property (nonatomic, copy) NSString * is_remind;//是否设置提醒 0没有 1有
//@property (nonatomic, copy) NSString * end_time;//"1504875600",//结束时间
//@property (nonatomic, copy) NSString * start_time;//"1504864800",//开始时间

- (void)sLimitBuyLimitBuyIndexSuccess:(SLimitBuyLimitBuyIndexSuccessBlock)success andFailure:(SLimitBuyLimitBuyIndexFailureBlock)failure;
@end
