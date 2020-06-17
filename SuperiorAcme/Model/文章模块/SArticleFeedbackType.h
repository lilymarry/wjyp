//
//  SArticleFeedbackType.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SArticleFeedbackTypeSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SArticleFeedbackTypeFailureBlock) (NSError * error);

@interface SArticleFeedbackType : NSObject

@property (nonatomic, strong) SArticleFeedbackType * data;
@property (nonatomic, copy) NSString * user_id;//"账号id",
@property (nonatomic, copy) NSString * real_name;//"姓名",

@property (nonatomic, copy) NSArray * feedback_type;//意见反馈类型列表
@property (nonatomic, copy) NSString * f_type_id;//"意见反馈类型id",
@property (nonatomic, copy) NSString * f_type_name;//"问题类型"

- (void)sArticleFeedbackTypeSuccess:(SArticleFeedbackTypeSuccessBlock)success andFailure:(SArticleFeedbackTypeFailureBlock)failure;
@end
