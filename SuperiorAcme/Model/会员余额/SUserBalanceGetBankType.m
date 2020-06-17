//
//  SUserBalanceGetBankType.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserBalanceGetBankType.h"

@implementation SUserBalanceGetBankType

- (void)sUserBalanceGetBankTypeSuccess:(SUserBalanceGetBankTypeSuccessBlock)success andFailure:(SUserBalanceGetBankTypeFailureBlock)failure {
    [HttpManager postWithUrl:SUserBalanceGetBankType_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SUserBalanceGetBankType mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SUserBalanceGetBankType"};
        }];
        success(dic[@"code"],dic[@"message"],[SUserBalanceGetBankType mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
