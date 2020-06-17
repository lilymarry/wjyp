//
//  SUserBalanceBalanceLog.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserBalanceBalanceLog.h"

@implementation SUserBalanceBalanceLog

- (void)sUserBalanceBalanceLogSuccess:(SUserBalanceBalanceLogSuccessBlock)success andFailure:(SUserBalanceBalanceLogFailureBlock)failure {
    [HttpManager postWithUrl:SUserBalanceBalanceLog_Url andParameters:@{@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SUserBalanceBalanceLog mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SUserBalanceBalanceLog",@"list":@"SUserBalanceBalanceLog"};
        }];
        success(dic[@"code"],dic[@"message"],[SUserBalanceBalanceLog mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
