//
//  SUserChangeIntegralStatus.m
//  SuperiorAcme
//
//  Created by GYM on 2018/2/24.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SUserChangeIntegralStatus.h"

@implementation SUserChangeIntegralStatus

- (void)sUserChangeIntegralStatusSuccess:(SUserChangeIntegralStatusSuccessBlock)success andFailure:(SUserChangeIntegralStatusFailureBlock)failure {
    [HttpManager postWithUrl:SUserChangeIntegralStatus_Url andParameters:@{@"status":_status} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
