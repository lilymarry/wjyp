//
//  SUserChangeIntegral.m
//  SuperiorAcme
//
//  Created by GYM on 2018/2/24.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SUserChangeIntegral.h"

@implementation SUserChangeIntegral

- (void)sUserChangeIntegralSuccess:(SUserChangeIntegralSuccessBlock)success andFailure:(SUserChangeIntegralFailureBlock)failure {
    [HttpManager postWithUrl:SUserChangeIntegral_Url andParameters:@{@"integral":_integral} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
