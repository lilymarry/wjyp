//
//  SIndexHeadLineList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/10/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SIndexHeadLineListSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SIndexHeadLineListFailureBlock) (NSError * error);

@interface SIndexHeadLineList : NSObject
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * headlines_id;//": "头条id",
@property (nonatomic, copy) NSString * title;//": "标题",
@property (nonatomic, copy) NSString * source;//": "来源",
@property (nonatomic, copy) NSString * logo;//": "图片"

- (void)sIndexHeadLineListSuccess:(SIndexHeadLineListSuccessBlock)success andFailure:(SIndexHeadLineListFailureBlock)failure;
@end
