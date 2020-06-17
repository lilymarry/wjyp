//
//  SArticleAboutUs.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SArticleAboutUsSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SArticleAboutUsFailureBlock) (NSError * error);

@interface SArticleAboutUs : NSObject

@property (nonatomic, strong) SArticleAboutUs * data;
@property (nonatomic, copy) NSString * company_name;//"国本（天津）信息技术有限公司",//公司名称
@property (nonatomic, copy) NSString * copyright;//"Copyright©2017 wujiemall.com"//版权申明

- (void)sArticleAboutUsSuccess:(SArticleAboutUsSuccessBlock)success andFailure:(SArticleAboutUsFailureBlock)failure;
@end
