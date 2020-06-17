//
//  SGoodsThreeList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SGoodsThreeListSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SGoodsThreeListFailureBlock) (NSError * error);

@interface SGoodsThreeList : NSObject
@property (nonatomic, copy) NSString * two_cate_id;//二级分类id
@property (nonatomic, copy) NSString * three_cate_id;//三级分类id (如不填默认全部)
@property (nonatomic, copy) NSString * is_active;//三级分类id (如不填默认全部)
@property (nonatomic, copy) NSString * p;//分页参数
@property (nonatomic, copy) NSString *searchType; //sell tsort integral
@property (nonatomic, copy) NSString *psort; //psort=1按价格从底到高，psort=2按价格从高到底
@property (nonatomic, copy) NSString *price; //价格区间内检索商品，格式是 开始金额_结束金额 ，两个价格中间用下划线链接


@property (nonatomic, strong) SGoodsThreeList * data;

//三级分类导航条
@property (nonatomic, copy) NSArray * three_cate_list;
//@property (nonatomic, copy) NSString * three_cate_id;//分类id,
@property (nonatomic, copy) NSString * short_name;//"分类简称",
@property (nonatomic, copy) NSString * name;

//商品
@property (nonatomic, copy) NSArray * list;
@property (nonatomic, copy) NSString * goods_id;//"商品ID",
@property (nonatomic, copy) NSString * goods_name;//"商品名称",
@property (nonatomic, copy) NSString * goods_img;//"商品图片",
@property (nonatomic, copy) NSString * market_price;//"市场价",
@property (nonatomic, copy) NSString * shop_price;//"销售价",
@property (nonatomic, copy) NSString * integral;//"积分",
@property (nonatomic, copy) NSString * sell_num;//"销量",
@property (nonatomic, copy) NSString * ticket_buy_id;//"",
@property (nonatomic, copy) NSString * country_id;//0表示中国
@property (nonatomic, copy) NSString * country_logo;//"国家Logo"
@property (nonatomic, copy) NSString * ticket_buy_discount;//"购物券折扣"
@property (nonatomic, copy) NSString *kucun_num;
- (void)sGoodsThreeListSuccess:(SGoodsThreeListSuccessBlock)success andFailure:(SGoodsThreeListFailureBlock)failure;
@end
