//
//  SGoodsSearch.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/21.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SGoodsSearchSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SGoodsSearchFailureBlock) (NSError * error);

@interface SGoodsSearch : NSObject
@property (nonatomic, copy) NSString * type;//搜索类型 1 商品 2商家
@property (nonatomic, copy) NSString * name;//搜索内容
@property (nonatomic, copy) NSString * p;//分页参数 默认为1 展示10条
@property (nonatomic, copy) NSString *searchType; //sell tsort integral
@property (nonatomic, copy) NSString *psort; //psort=1按价格从底到高，psort=2按价格从高到底
@property (nonatomic, copy) NSString *price; //价格区间内检索商品，格式是 开始金额_结束金额 ，两个价格中间用下划线链接

@property (nonatomic, strong) SGoodsSearch * data;
@property (nonatomic, copy) NSString * search_content;//"搜索的内容"

@property (nonatomic, copy) NSArray * list;

//商品
@property (nonatomic, copy) NSString * goods_id;//": "商品ID",
@property (nonatomic, copy) NSString * goods_name;//": "商品名称",
@property (nonatomic, copy) NSString * goods_img;//": "商品图片",
@property (nonatomic, copy) NSString * market_price;//": "市场价",
@property (nonatomic, copy) NSString * shop_price;//": "销售价",
@property (nonatomic, copy) NSString * integral;//": "积分",
@property (nonatomic, copy) NSString * sell_num;//": "销量",
@property (nonatomic, copy) NSString * ticket_buy_id;//": "",
@property (nonatomic, copy) NSString * country_id;//": "0", //0表示中国
@property (nonatomic, copy) NSString * country_logo;//":"国家Logo"
@property (nonatomic, copy) NSString * ticket_buy_discount;//": "购物券折扣"

//商家
@property (nonatomic, strong) SGoodsSearch * merInfo;
@property (nonatomic, copy) NSString * merchant_id;//": "店铺id",
@property (nonatomic, copy) NSString * merchant_name;//": "店铺名称",
@property (nonatomic, copy) NSString * merchant_desc;//": "店铺简介",
@property (nonatomic, copy) NSString * score;//": "店铺评分",
@property (nonatomic, copy) NSString * logo;//": "店铺logo"
//店铺下商品列表
@property (nonatomic, copy) NSArray * goodsList;
//@property (nonatomic, copy) NSString * goods_id;//": "商品id",
//@property (nonatomic, copy) NSString * goods_img;//": "商品图片",
//@property (nonatomic, copy) NSString * shop_price;//": "售价"

- (void)sGoodsSearchSuccess:(SGoodsSearchSuccessBlock)success andFailure:(SGoodsSearchFailureBlock)failure;
@end
