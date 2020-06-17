//
//  SArticleFeedbackType.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SArticleFeedbackType.h"

@implementation SArticleFeedbackType

- (void)sArticleFeedbackTypeSuccess:(SArticleFeedbackTypeSuccessBlock)success andFailure:(SArticleFeedbackTypeFailureBlock)failure {
    [HttpManager postWithUrl:SArticleFeedbackType_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SArticleFeedbackType mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"feedback_type":@"SArticleFeedbackType"};
        }];
        success(dic[@"code"],dic[@"message"],[SArticleFeedbackType mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
