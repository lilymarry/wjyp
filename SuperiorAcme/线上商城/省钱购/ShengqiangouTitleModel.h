//
//  ShengqiangouTitleModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/19.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^ShengqiangouTitleModelSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^ShengqiangouTitleModelFailureBlock) (NSError * error);

@interface ShengqiangouTitleModel : NSObject

@property (nonatomic, strong) NSArray * data;

@property (nonatomic, copy) NSString * name;
@property (nonatomic, copy) NSString * is_default;



- (void)ShengqiangouTitleModelSuccess:(ShengqiangouTitleModelSuccessBlock)success andFailure:(ShengqiangouTitleModelFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
