//
//  SRecommendingAdvertImg.m
//  SuperiorAcme
//
//  Created by GYM on 2018/2/3.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SRecommendingAdvertImg.h"

@implementation SRecommendingAdvertImg

- (void)sRecommendingAdvertImgSuccess:(SRecommendingAdvertImgSuccessBlock)success andFailure:(SRecommendingAdvertImgFailureBlock)failure {
    [HttpManager postWithUrl:SRecommendingAdvertImg_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SRecommendingAdvertImg mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SRecommendingAdvertImg"};
        }];
        success(dic[@"code"],dic[@"message"],[SRecommendingAdvertImg mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
