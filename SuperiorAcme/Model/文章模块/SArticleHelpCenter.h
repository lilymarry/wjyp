//
//  SArticleHelpCenter.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SArticleHelpCenterSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SArticleHelpCenterFailureBlock) (NSError * error);

@interface SArticleHelpCenter : NSObject<NSCoding,NSCopying>
@property (nonatomic, copy) NSString * type;//类型:type:0链客篇，type:1商家篇，2用户篇，3运营中心篇 4互清库存：攻略 5互清库存：常见问题

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * title;//"标题",
@property (nonatomic, copy) NSString * content;//"内容//纯文本
@property (nonatomic, assign) BOOL is_no;

#pragma mark 互清库存
@property (assign,nonatomic) BOOL isChild;
@property (assign,nonatomic) BOOL isExpended;
@property (assign,nonatomic) CGFloat  webHeight;

- (void)sArticleHelpCenterSuccess:(SArticleHelpCenterSuccessBlock)success anFailure:(SArticleHelpCenterFailureBlock)failure;
@end
