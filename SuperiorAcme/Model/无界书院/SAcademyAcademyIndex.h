//
//  SAcademyAcademyIndex.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SAcademyAcademyIndexSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SAcademyAcademyIndexFailureBlock) (NSError * error);

@interface SAcademyAcademyIndex : NSObject
@property (nonatomic, copy) NSString * ac_type_id;//分类ID 若不写默认显示推荐文章
@property (nonatomic, copy) NSString * p;//分页参数 默认每页10条数据

@property (nonatomic, strong) SAcademyAcademyIndex * data;

@property (nonatomic, copy) NSArray * ac_type_list;//分类列表
@property (nonatomic, copy) NSString * type_id;//分类id,
@property (nonatomic, copy) NSString * type_name;//“分类名称”

@property (nonatomic, copy) NSArray * bannerList;//轮播图列表
@property (nonatomic, copy) NSString * ads_id;//"轮播图id",
@property (nonatomic, copy) NSString * desc;//"轮播图说明",
@property (nonatomic, copy) NSString * picture;//"图片路径"
@property (nonatomic, copy) NSString * merchant_id;//”：“店铺id”
@property (nonatomic, copy) NSString * goods_id;//”：“商品id”
@property (nonatomic, copy) NSString * href;//": "广告链接"

@property (nonatomic, copy) NSArray * academy_list;//文章列表
@property (nonatomic, copy) NSString * academy_id;//"文章id",
@property (nonatomic, copy) NSString * title;//"文章标题",
@property (nonatomic, copy) NSString * logo;//"文章封面图",
@property (nonatomic, copy) NSString * page_views;//"浏览量",
@property (nonatomic, copy) NSString * collect_num;//"收藏数"

- (void)sAcademyAcademyIndexSuccess:(SAcademyAcademyIndexSuccessBlock)success andFailure:(SAcademyAcademyIndexFailureBlock)failure;
@end
