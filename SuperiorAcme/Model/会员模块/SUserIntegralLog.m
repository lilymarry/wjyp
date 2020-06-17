//
//  SUserIntegralLog.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserIntegralLog.h"

@implementation SUserIntegralLog

- (void)sUserIntegralLogSuccess:(SUserIntegralLogSuccessBlock)success andFailure:(SUserIntegralLogFailureBlock)failure {
    [HttpManager postWithUrl:SUserIntegralLog_Url andParameters:@{@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SUserIntegralLog mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SUserIntegralLog",@"list":@"SUserIntegralLog"};
        }];
        success(dic[@"code"],dic[@"message"],[SUserIntegralLog mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
