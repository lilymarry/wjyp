//
//  SUserUserDevelopLog.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserUserDevelopLog.h"

@implementation SUserUserDevelopLog

- (void)sUserUserDevelopLogSuccess:(SUserUserDevelopLogSuccessBlock)success andFailure:(SUserUserDevelopLogFailureBlock)failure {
    [HttpManager postWithUrl:SUserUserDevelopLog_Url andParameters:@{@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SUserUserDevelopLog mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SUserUserDevelopLog",@"list":@"SUserUserDevelopLog"};
        }];
        success(dic[@"code"],dic[@"message"],[SUserUserDevelopLog mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
