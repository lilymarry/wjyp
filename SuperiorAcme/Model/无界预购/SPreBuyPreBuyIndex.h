//
//  SPreBuyPreBuyIndex.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SPreBuyPreBuyIndexSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SPreBuyPreBuyIndexFailureBlock) (NSError * error);

@interface SPreBuyPreBuyIndex : NSObject
@property (nonatomic, copy) NSString * cate_id;//分类id
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, strong) SPreBuyPreBuyIndex * data;

//顶级分类导航条
@property (nonatomic, copy) NSArray * top_nav;
//@property (nonatomic, copy) NSString * cate_id;//"分类ID",
@property (nonatomic, copy) NSString * short_name;//"分类简称",
@property (nonatomic, copy) NSString * name;//"分类名称"

//二级分类列表
@property (nonatomic, copy) NSArray * two_cate_list;
@property (nonatomic, copy) NSString * two_cate_id;//"二级分类id",
//@property (nonatomic, copy) NSString * short_name;//"分类简称",
//@property (nonatomic, copy) NSString * name;//"分类名称"
@property (nonatomic, copy) NSString * cate_img;//"二级分类图标"

@property (nonatomic, strong) SPreBuyPreBuyIndex * ads;
@property (nonatomic, copy) NSString * ads_id;//"广告ID",
@property (nonatomic, copy) NSString * picture;//"广告图片",
@property (nonatomic, copy) NSString * desc;// "广告说明",
@property (nonatomic, copy) NSString * merchant_id;//”：“店铺id”
@property (nonatomic, copy) NSString * goods_id;//”：“商品id”
@property (nonatomic, copy) NSString * href;//": "广告链接"

@property (nonatomic, copy) NSArray * pre_buy_list;
@property (nonatomic, copy) NSString * pre_buy_id;//"预购id",
@property (nonatomic, copy) NSString * deposit;//"定金",
@property (nonatomic, copy) NSString * pre_store;//"预购库存",
@property (nonatomic, copy) NSString * sell_num;//"销量",
@property (nonatomic, copy) NSString * start_time;//"开始时间",
@property (nonatomic, copy) NSString * end_time;//"结束时间",
@property (nonatomic, copy) NSString * integral;//"积分",
@property (nonatomic, copy) NSString * market_price;//'市场价'
@property (nonatomic, copy) NSString * goods_name;//"商品名称",
@property (nonatomic, copy) NSString * goods_img;//"商品图片",
@property (nonatomic, copy) NSString * country_id;//"国家ID",
@property (nonatomic, copy) NSString * country_logo;//国家logo
@property (nonatomic, copy) NSString * ticket_buy_id;//"票券id",
@property (nonatomic, copy) NSString * ticket_buy_discount;//"折扣率"
@property (nonatomic, copy) NSString * success_max_num;

- (void)sPreBuyPreBuyIndexSuccess:(SPreBuyPreBuyIndexSuccessBlock)success andFailure:(SPreBuyPreBuyIndexFailureBlock)failure;
@end
