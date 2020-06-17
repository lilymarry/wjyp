//
//  SCountryCountryIndex.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/4.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SCountryCountryIndexSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SCountryCountryIndexFailureBlock) (NSError * error);

@interface SCountryCountryIndex : NSObject
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, strong) SCountryCountryIndex * data;

@property (nonatomic, strong) SCountryCountryIndex * ads;
@property (nonatomic, copy) NSString * ads_id;//ads_id
@property (nonatomic, copy) NSString * picture;//"广告图片",
@property (nonatomic, copy) NSString * desc;//"广告说明",
@property (nonatomic, copy) NSString * merchant_id;//”：“店铺id”
//@property (nonatomic, copy) NSString * goods_id;//”：“商品id”
@property (nonatomic, copy) NSString * href;//": "广告链接"

@property (nonatomic, copy) NSArray * country_list;
@property (nonatomic, copy) NSString * country_id;//"国家ID",
@property (nonatomic, copy) NSString * house_img;//"国家Logo",
@property (nonatomic, copy) NSString * country_name;//"国家名称"

@property (nonatomic, copy) NSArray * goods_list;
@property (nonatomic, copy) NSString * goods_id;//"商品id",
@property (nonatomic, copy) NSString * goods_name;//"商品名称",
@property (nonatomic, copy) NSString * goods_img;//"商品图片",
@property (nonatomic, copy) NSString * market_price;//"市场价",
@property (nonatomic, copy) NSString * shop_price;// "销售价",
@property (nonatomic, copy) NSString * sell_num;//"已售数量",
@property (nonatomic, copy) NSString * integral;//"积分",
//@property (nonatomic, copy) NSString * country_id;//"国家ID",
@property (nonatomic, copy) NSString * ticket_buy_id;//"票券ID",
@property (nonatomic, copy) NSString * ticket_buy_discount;//"票券折扣率",  //当票券id大于0时出现
@property (nonatomic, copy) NSString * country_logo;//"国家logo"

- (void)sCountryCountryIndexSuccess:(SCountryCountryIndexSuccessBlock)success andFailure:(SCountryCountryIndexFailureBlock)failure;
@end
