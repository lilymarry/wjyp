//
//  SAcademyAcademyInfo.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SAcademyAcademyInfoSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SAcademyAcademyInfoFailureBlock) (NSError * error);

@interface SAcademyAcademyInfo : NSObject
@property (nonatomic, copy) NSString * academy_id;//文章id

@property (nonatomic, strong) SAcademyAcademyInfo * data;
//@property (nonatomic, copy) NSString * academy_id;//"文章id",
@property (nonatomic, copy) NSString * title;//"文章标题",
@property (nonatomic, copy) NSString * logo;//"封面图片地址",
@property (nonatomic, copy) NSString * content;//"文章内容",
@property (nonatomic, copy) NSString * source;//"文章来源",
@property (nonatomic, copy) NSString * page_views;//"浏览量",
@property (nonatomic, copy) NSString * collect_num;//"收藏数",
@property (nonatomic, copy) NSString * create_time;//"创建时间",
@property (nonatomic, copy) NSString * is_collect;// "是否收藏" //1 收藏 0未收藏

- (void)sAcademyAcademyInfoSuccess:(SAcademyAcademyInfoSuccessBlock)success andFailure:(SAcademyAcademyInfoFailureBlock)failure;
@end
