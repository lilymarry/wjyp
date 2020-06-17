//
//  SThemeThemeGoods.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SThemeThemeGoodsSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SThemeThemeGoodsFailureBlock) (NSError * error);

@interface SThemeThemeGoods : NSObject
@property (nonatomic, copy) NSString * theme_id;//主题ID
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, strong) SThemeThemeGoods * data;
@property (nonatomic, copy) NSString * theme_img;//"主题图片",
@property (nonatomic, copy) NSString * merchant_id;//”：“店铺id”
//@property (nonatomic, copy) NSString * goods_id;//”：“商品id”
@property (nonatomic, copy) NSString * href;//": "广告链接"

@property (nonatomic, copy) NSArray * list;
@property (nonatomic, copy) NSString * goods_id;//"商品id",
@property (nonatomic, copy) NSString * goods_name;//"商品名称",
@property (nonatomic, copy) NSString * goods_img;//"商品图片",
@property (nonatomic, copy) NSString * market_price;//"市场价",
@property (nonatomic, copy) NSString * shop_price;//"售价",
@property (nonatomic, copy) NSString * integral;//"积分",
@property (nonatomic, copy) NSString * sell_num;//"已售数量",
@property (nonatomic, copy) NSString * ticket_buy_id;//"是否是折扣商品",//0 不是 大于0就是
@property (nonatomic, copy) NSString * ticket_buy_discount;//"折扣率",//在是折扣商品时才会有
@property (nonatomic, copy) NSString * country_id;//"国家id",
@property (nonatomic, copy) NSString * country_logo;//"国家logo"

- (void)sThemeThemeGoodsSuccess:(SThemeThemeGoodsSuccessBlock)success andFailure:(SThemeThemeGoodsFailureBlock)failure;
@end
