//
//  SRecommendingBusinessType.m
//  SuperiorAcme
//
//  Created by GYM on 2018/2/2.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SRecommendingBusinessType.h"

@implementation SRecommendingBusinessType

- (void)sRecommendingBusinessTypeSuccess:(SRecommendingBusinessTypeSuccessBlock)success andFailure:(SRecommendingBusinessTypeFailureBlock)failure {
    [HttpManager postWithUrl:SRecommendingBusinessType_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SRecommendingBusinessType mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SRecommendingBusinessType"};
        }];
        success(dic[@"code"],dic[@"message"],[SRecommendingBusinessType mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
