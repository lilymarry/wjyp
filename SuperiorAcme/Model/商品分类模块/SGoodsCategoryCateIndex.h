//
//  SGoodsCategoryCateIndex.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/5.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SGoodsCategoryCateIndexSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SGoodsCategoryCateIndexFailureBlock) (NSError * error);

@interface SGoodsCategoryCateIndex : NSObject
@property (nonatomic, copy) NSString * cate_id;//顶级分类id

@property (nonatomic, strong) SGoodsCategoryCateIndex * data;
@property (nonatomic, copy) NSString * msg_tip;//"1",

//顶级分类列表
@property (nonatomic, copy) NSArray * top_cate;
//@property (nonatomic, copy) NSString * cate_id;//"分类id",
@property (nonatomic, copy) NSString * short_name;//"分类简称",
@property (nonatomic, copy) NSString * name;//"分类名称"
@property (nonatomic, assign) BOOL top_cate_isno;

//二级分类列表
@property (nonatomic, copy) NSArray * two_cate;
//@property (nonatomic, copy) NSString * cate_id;//"分类id",
//@property (nonatomic, copy) NSString * short_name;//"分类简称",
//@property (nonatomic, copy) NSString * name;//"分类名称",
@property (nonatomic, copy) NSString * hot_brand;//"1,2,3,4",//暂无作用
@property (nonatomic, copy) NSString * cate_img;//"品牌图片",
//热门品牌
@property (nonatomic, copy) NSArray * host_brand;
@property (nonatomic, copy) NSString * brand_id;//"品牌id",
@property (nonatomic, copy) NSString * brand_logo;//"品牌logo",
@property (nonatomic, copy) NSString * brand_name;//"品牌名称"
//三级分类列表
@property (nonatomic, copy) NSArray * three_cate;
//@property (nonatomic, copy) NSString * cate_id;//"分类id",
//@property (nonatomic, copy) NSString * short_name;//"分类简称",
//@property (nonatomic, copy) NSString * name;//"分类名称",
//@property (nonatomic, copy) NSString * hot_brand;//"0",
//@property (nonatomic, copy) NSString * cate_img;//"品牌图标"

- (void)sGoodsCategoryCateIndexSuccess:(SGoodsCategoryCateIndexSuccessBlock)success andFailure:(SGoodsCategoryCateIndexFailureBlock)failure;
@end
