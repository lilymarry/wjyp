//
//  SUserMyfooter.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserMyfooterSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SUserMyfooterFailureBlock) (NSError * error);

@interface SUserMyfooter : NSObject
@property (nonatomic, copy) NSString * type;//类型参数 1商品（默认） 2店铺 3书院
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, assign) BOOL choice_isno;
@property (nonatomic, copy) NSString * footer_id;//

//type == 1
@property (nonatomic, copy) NSString * goods_id;//"商品ID",
@property (nonatomic, copy) NSString * goods_name;//"商品名称",
@property (nonatomic, copy) NSString * goods_img;//"商品图片",
@property (nonatomic, copy) NSString * market_price;//"市场价",
@property (nonatomic, copy) NSString * shop_price;//"销售价",
@property (nonatomic, copy) NSString * integral;//"积分",
@property (nonatomic, copy) NSString * sell_num;//"销量",
@property (nonatomic, copy) NSString * ticket_buy_id;//"",
@property (nonatomic, copy) NSString * country_id;//"0", //0表示中国
@property (nonatomic, copy) NSString * country_logo;//国家logo
@property (nonatomic, copy) NSString * is_buy;//"1", //1 上架 2 下架
@property (nonatomic, copy) NSString * add_time;//"0",//添加时间
@property (nonatomic, copy) NSString * ticket_buy_discount;//"购物券折扣"

//type == 2
@property (nonatomic, copy) NSString * id_val;//"店铺对应的id",

@property (nonatomic, strong) SUserMyfooter * merInfo;
@property (nonatomic, copy) NSString * merchant_id;//"店铺id",
@property (nonatomic, copy) NSString * merchant_name;//"店铺名称",
@property (nonatomic, copy) NSString * merchant_desc;//"店铺简介",
@property (nonatomic, copy) NSString * score;// "评分",
@property (nonatomic, copy) NSString * logo;//"店铺logo"

@property (nonatomic, copy) NSArray * goodsList;//三个封面商品
//@property (nonatomic, copy) NSString * goods_id;//"商品ID",
//@property (nonatomic, copy) NSString * goods_img;//"商品图片",
//@property (nonatomic, copy) NSString * shop_price;//"商品价格"

//type == 3
@property (nonatomic, copy) NSString * academy_id;//"文章id",
@property (nonatomic, copy) NSString * title;//"标题",
//@property (nonatomic, copy) NSString * logo;//"封面图",
@property (nonatomic, copy) NSString * page_views;//"浏览量",
@property (nonatomic, copy) NSString * collect_num;//"收藏数"

/*
 *   线下
 */

/**
 店铺ID
 */
@property (nonatomic, copy) NSString * s_id;

@property (nonatomic, assign) BOOL isSearch;
@property (nonatomic, assign) NSInteger user_id;
/**
 距离
 */
@property (nonatomic, copy) NSString * distance;
/**
 月消单
 */
@property (nonatomic, copy) NSString * months_order;

@property (nonatomic, copy) NSString * goods_num;
- (void)sUserMyfooterSuccess:(SUserMyfooterSuccessBlock)success andFailure:(SUserMyfooterFailureBlock)failure;
@end
