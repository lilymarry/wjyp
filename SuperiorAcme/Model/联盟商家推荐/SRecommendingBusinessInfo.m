//
//  SRecommendingBusinessInfo.m
//  SuperiorAcme
//
//  Created by GYM on 2018/2/2.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SRecommendingBusinessInfo.h"

@implementation SRecommendingBusinessInfo

+(NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"desc" : @"description"};
}

- (void)sRecommendingBusinessInfoSuccess:(SRecommendingBusinessInfoSuccessBlock)success andFailure:(SRecommendingBusinessInfoFailureBlock)failure {
    [HttpManager postWithUrl:SRecommendingBusinessInfo_Url andParameters:@{@"recommending_id":_recommending_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SRecommendingBusinessInfo mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
