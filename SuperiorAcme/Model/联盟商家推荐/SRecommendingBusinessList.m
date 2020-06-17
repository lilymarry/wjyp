//
//  SRecommendingBusinessList.m
//  SuperiorAcme
//
//  Created by GYM on 2018/2/2.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SRecommendingBusinessList.h"

@implementation SRecommendingBusinessList

- (void)sRecommendingBusinessListSuccess:(SRecommendingBusinessListSuccessBlock)success andFailure:(SRecommendingBusinessListFailureBlock)failure {
    [HttpManager getWithUrl:SRecommendingBusinessList_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SRecommendingBusinessList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SRecommendingBusinessList"};
        }];
        success(dic[@"code"],dic[@"message"],[SRecommendingBusinessList mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
