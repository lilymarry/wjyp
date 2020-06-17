//
//  SCountryCountryGoods.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/4.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SCountryCountryGoodsSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SCountryCountryGoodsFailureBlock) (NSError * error);

@interface SCountryCountryGoods : NSObject
@property (nonatomic, copy) NSString * country_id;//国家ID
@property (nonatomic, copy) NSString * cate_id;//分类id 默认显示第一个顶级分类的推荐
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, strong) SCountryCountryGoods * data;
@property (nonatomic, copy) NSString * title;//"国家标题",

//顶级分类导航条
@property (nonatomic, copy) NSArray * top_nav;
//@property (nonatomic, copy) NSString * cate_id;//"顶级分类id",
@property (nonatomic, copy) NSString * short_name;// "分类简称",
@property (nonatomic, copy) NSString * name;//"分类名称"

//二级分类列表
@property (nonatomic, copy) NSArray * two_cate_list;
@property (nonatomic, copy) NSString * two_cate_id;//"二级分类id",
//@property (nonatomic, copy) NSString * short_name;//"分类简称",
//@property (nonatomic, copy) NSString * name;//"分类名称"
@property (nonatomic, copy) NSString * cate_img;//"二级分类图标"

@property (nonatomic, strong) SCountryCountryGoods * ads;
@property (nonatomic, copy) NSString * ads_id;//"广告ID",
@property (nonatomic, copy) NSString * picture;//"广告图片",
@property (nonatomic, copy) NSString * desc;//"广告说明",
@property (nonatomic, copy) NSString * merchant_id;//”：“店铺id”
//@property (nonatomic, copy) NSString * goods_id;//”：“商品id”
@property (nonatomic, copy) NSString * href;//": "广告链接"

@property (nonatomic, copy) NSArray * list;
@property (nonatomic, copy) NSString * goods_id;//"商品ID",
@property (nonatomic, copy) NSString * goods_name;//"商品名称",
@property (nonatomic, copy) NSString * goods_img;//"商品图片",
@property (nonatomic, copy) NSString * market_price;//"市场价",
@property (nonatomic, copy) NSString * shop_price;//"销售价",
@property (nonatomic, copy) NSString * integral;//"积分",
@property (nonatomic, copy) NSString * sell_num;//"销量",
@property (nonatomic, copy) NSString * ticket_buy_id;//"",
//@property (nonatomic, copy) NSString * country_id;//"0", //0表示中国
@property (nonatomic, copy) NSString * country_logo;//"国家Logo"
@property (nonatomic, copy) NSString * ticket_buy_discount;//"购物券折扣"
@property (nonatomic, copy) NSString * label_int;
- (void)sCountryCountryGoodsSuccess:(SCountryCountryGoodsSuccessBlock)success andFailure:(SCountryCountryGoodsFailureBlock)failure;
@end
