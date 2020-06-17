//
//  SIntegralBuyThreeList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SIntegralBuyThreeListSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SIntegralBuyThreeListFailureBlock) (NSError * error);

@interface SIntegralBuyThreeList : NSObject
@property (nonatomic, copy) NSString * two_cate_id;//二级分类id
@property (nonatomic, copy) NSString * three_cate_id;//三级分类id
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, strong) SIntegralBuyThreeList * data;

//三级分类列表
@property (nonatomic, copy) NSArray * three_cate_list;
//@property (nonatomic, copy) NSString * three_cate_id;//": "三级分类id",
@property (nonatomic, copy) NSString * short_name;//": "分类简称",
@property (nonatomic, copy) NSString * name;//": "分类名称"

@property (nonatomic, copy) NSArray * integral_buy_list;
@property (nonatomic, copy) NSString * goods_id;//": "商品id",
@property (nonatomic, copy) NSString * goods_name;//": "商品名称",
@property (nonatomic, copy) NSString * goods_img;//": "商品图片",
@property (nonatomic, copy) NSString * use_integral;//": "兑换所需积分",
@property (nonatomic, copy) NSString * integral_buy_id;//": "积分商品对应的id",
@property (nonatomic, copy) NSString * country_id;//": "国家id",
@property (nonatomic, copy) NSString * country_logo;//": "国家logo"

- (void)sIntegralBuyThreeListSuccess:(SIntegralBuyThreeListSuccessBlock)success andFailure:(SIntegralBuyThreeListFailureBlock)failure;
@end
