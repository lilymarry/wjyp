//
//  SArticleFeedback.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SArticleFeedbackSuccessBlock) (NSString * code, NSString * message);
typedef void(^SArticleFeedbackFailureBlock) (NSError * error);

@interface SArticleFeedback : NSObject
@property (nonatomic, copy) NSString * f_type_id;//意见反馈类型id
@property (nonatomic, copy) NSString * content;//意见反馈类型

- (void)sArticleFeedbackSuccess:(SArticleFeedbackSuccessBlock)success andFailure:(SArticleFeedbackFailureBlock)failure;
@end
