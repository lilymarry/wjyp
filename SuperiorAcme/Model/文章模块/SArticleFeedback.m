//
//  SArticleFeedback.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SArticleFeedback.h"

@implementation SArticleFeedback

- (void)sArticleFeedbackSuccess:(SArticleFeedbackSuccessBlock)success andFailure:(SArticleFeedbackFailureBlock)failure {
    [HttpManager postWithUrl:SArticleFeedback_Url andParameters:@{@"f_type_id":_f_type_id,@"content":_content} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
