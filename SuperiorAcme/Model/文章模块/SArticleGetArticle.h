//
//  SArticleGetArticle.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SArticleGetArticleSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SArticleGetArticleFailureBlock) (NSError * error);

@interface SArticleGetArticle : NSObject
@property (nonatomic, copy) NSString * type;//类型: type 1注册 服务条款

@property (nonatomic, strong) SArticleGetArticle * data;
@property (nonatomic, copy) NSString * title;//"文章标题",
@property (nonatomic, copy) NSString * content;//"文章内容"//html格式

- (void)sArticleGetArticleSuccess:(SArticleGetArticleSuccessBlock)success andFailure:(SArticleGetArticleFailureBlock)failure;
@end
