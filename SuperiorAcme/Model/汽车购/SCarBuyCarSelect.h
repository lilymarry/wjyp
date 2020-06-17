//
//  SCarBuyCarSelect.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/5.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SCarBuyCarSelectSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SCarBuyCarSelectFailureBlock) (NSError * error);

@interface SCarBuyCarSelect : NSObject

@property (nonatomic, strong) SCarBuyCarSelect * data;

@property (nonatomic, copy) NSArray * style_list;
@property (nonatomic, copy) NSString * style_id;//"型号ID",
@property (nonatomic, copy) NSString * style_name;//"型号名称",
@property (nonatomic, copy) NSString * style_img;//"车型未选中图片",
@property (nonatomic, copy) NSString * true_style_img;//"选中图片"
@property (nonatomic, assign) BOOL style_type;

@property (nonatomic, copy) NSArray * brand_list;
@property (nonatomic, copy) NSString * brand_id;//"品牌ID",
@property (nonatomic, copy) NSString * brand_name;//"品牌名称",
@property (nonatomic, copy) NSString * brand_logo;//"品牌logo"
@property (nonatomic, copy) NSString * true_brand_logo;//"选中品牌logo"
@property (nonatomic, assign) BOOL brand_type;

- (void)sCarBuyCarSelectSuccess:(SCarBuyCarSelectSuccessBlock)success andFailure:(SCarBuyCarSelectFailureBlock)failure;
@end
