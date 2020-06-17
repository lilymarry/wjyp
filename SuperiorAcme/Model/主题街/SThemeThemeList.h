//
//  SThemeThemeList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SThemeThemeListSuccessBlock) (NSString * code, NSString * message, id data, NSString * nums);
typedef void(^SThemeThemeListFailureBlock) (NSError * error);

@interface SThemeThemeList : NSObject
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * theme_id;//"主题ID",
@property (nonatomic, copy) NSString * theme_name;//"主题数量"
@property (nonatomic, copy) NSString * theme_img;//"主题名称"

- (void)sThemeThemeListSuccess:(SThemeThemeListSuccessBlock)success andFailure:(SThemeThemeListFailureBlock)failure;
@end
