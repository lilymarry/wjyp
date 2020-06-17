//
//  SIndexHeadInfo.h
//  SuperiorAcme
//
//  Created by GYM on 2017/10/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SIndexHeadInfoSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SIndexHeadInfoFailureBlock) (NSError * error);

@interface SIndexHeadInfo : NSObject
@property (nonatomic, copy) NSString * headlines_id;//头条id

@property (nonatomic, strong) SIndexHeadInfo * data;
@property (nonatomic, copy) NSString * id;//": "3",
@property (nonatomic, copy) NSString * title;//": "标题",
@property (nonatomic, copy) NSString * logo;//": "图片",
@property (nonatomic, copy) NSString * content;//": "内容",//HTML
@property (nonatomic, copy) NSString * source;//": "来源",
@property (nonatomic, copy) NSString * create_time;//": "创建时间",
@property (nonatomic, copy) NSString * update_time;//": "修改时间",

- (void)sIndexHeadInfoSuccess:(SIndexHeadInfoSuccessBlock)success andFailure:(SIndexHeadInfoFailureBlock)failure;
@end
