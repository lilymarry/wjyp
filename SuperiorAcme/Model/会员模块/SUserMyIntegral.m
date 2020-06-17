//
//  SUserMyIntegral.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserMyIntegral.h"

@implementation SUserMyIntegral

- (void)sUserMyIntegralSuccess:(SUserMyIntegralSuccessBlock)success andFailure:(SUserMyIntegralFailureBlock)failure {
    [HttpManager postWithUrl:SUserMyIntegral_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SUserMyIntegral mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"point_list":@"SUserMyIntegral"};
        }];
        success(dic[@"code"],dic[@"message"],[SUserMyIntegral mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
