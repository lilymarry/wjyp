//
//  SCompanyDevelopCompanyList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SCompanyDevelopCompanyListSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SCompanyDevelopCompanyListFailureBlock) (NSError * error);

@interface SCompanyDevelopCompanyList : NSObject
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, strong) SCompanyDevelopCompanyList * data;

//轮播广告
@property (nonatomic, copy) NSArray * ads;
@property (nonatomic, copy) NSString * ads_id;//": "广告id",
@property (nonatomic, copy) NSString * picture;//": "轮播图",
@property (nonatomic, copy) NSString * desc;//": "描述",
@property (nonatomic, copy) NSString * position;//": "20"//位置参数
@property (nonatomic, copy) NSString * merchant_id;//”：“店铺id”
@property (nonatomic, copy) NSString * goods_id;//”：“商品id”
@property (nonatomic, copy) NSString * href;//": "广告链接"

@property (nonatomic, copy) NSArray * mer_list;
@property (nonatomic, copy) NSString * company_id;//": "企业id",
@property (nonatomic, copy) NSString * face_img;//": "企业封面图片",
//@property (nonatomic, copy) NSString * merchant_id;//": "店铺id"

- (void)sCompanyDevelopCompanyListSuccess:(SCompanyDevelopCompanyListSuccessBlock)success andFailure:(SCompanyDevelopCompanyListFailureBlock)failure;
@end
