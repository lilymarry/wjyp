//
//  SGoodsGoodsList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/28.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
typedef void(^SGoodsGoodsListSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void (^SGoodsGoodsListFailureBlock) (NSError * error);

@interface SGoodsGoodsList : BaseModel
@property (nonatomic, copy) NSString * cate_id;//分类id
@property (nonatomic, copy) NSString * p;//分页参数u
@property (nonatomic, copy) NSString * is_active;//只有在爆款专区时传 一定传 5   互清库存传7
@property (nonatomic, strong) SGoodsGoodsList * data;

@property (nonatomic, strong) SGoodsGoodsList * ads;
@property (nonatomic, copy) NSString * ads_id;//"广告ID",
@property (nonatomic, copy) NSString * picture;//"广告图片",
@property (nonatomic, copy) NSString * desc;//"广告说明",
@property (nonatomic, copy) NSString * merchant_id;//”：“店铺id”
//@property (nonatomic, copy) NSString * goods_id;//”：“商品id”
@property (nonatomic, copy) NSString * href;//": "广告链接"

@property (nonatomic, copy) NSArray * top_nav;//顶级分类导航条
//@property (nonatomic, copy) NSString * cate_id;//3,
@property (nonatomic, copy) NSString * short_name;//"分类简称",
@property (nonatomic, copy) NSString * name;// "分类名称"

//二级分类列表
@property (nonatomic, copy) NSArray * two_cate_list;
@property (nonatomic, copy) NSString * two_cate_id;//"二级分类id",
//@property (nonatomic, copy) NSString * short_name;//"分类简称",
//@property (nonatomic, copy) NSString * name;//"分类名称"
@property (nonatomic, copy) NSString * cate_img;//"二级分类图标"

@property (nonatomic, copy) NSArray * list;
@property (nonatomic, copy) NSString * goods_id;//"商品ID",
@property (nonatomic, copy) NSString * goods_name;//"商品名称",
@property (nonatomic, copy) NSString * goods_img;// "商品图片",
@property (nonatomic, copy) NSString * market_price;//"市场价",
@property (nonatomic, copy) NSString * shop_price;//"销售价",
@property (nonatomic, copy) NSString * integral;//"积分",
@property (nonatomic, copy) NSString * sell_num;//"销量",
@property (nonatomic, copy) NSString * ticket_buy_id;//"",
@property (nonatomic, copy) NSString * country_id;//0表示中国
@property (nonatomic, copy) NSString * country_logo;//"国家Logo"
@property (nonatomic, copy) NSString * ticket_buy_discount;// "购物券折扣"
//@property (nonatomic, copy) NSString * group_type;// "购物券折扣"
//@property (nonatomic, copy) NSString * group_price;// "购物券折扣"
//@property (nonatomic, copy) NSString * group_num;// "购物券折扣"
//@property (nonatomic, copy) NSString * total;// "购物券折扣"

@property (nonatomic, copy) NSString * kucun_num;// "购物券折扣"

- (void)sGoodsGoodsListSuccess:(SGoodsGoodsListSuccessBlock)success andFailure:(SGoodsGoodsListFailureBlock)failure;
@end
