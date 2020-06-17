//
//  SUserBalanceGetUserName.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserBalanceGetUserName.h"

@implementation SUserBalanceGetUserName

- (void)sUserBalanceGetUserNameSuccess:(SUserBalanceGetUserNameSuccessBlock)success andFailure:(SUserBalanceGetUserNameFailureBlock)failure {
    [HttpManager postWithUrl:SUserBalanceGetUserName_Url andParameters:@{@"code":_code} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SUserBalanceGetUserName mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
