//
//  SUserBalancePlatformAccount.m
//  SuperiorAcme
//
//  Created by GYM on 2018/2/24.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SUserBalancePlatformAccount.h"

@implementation SUserBalancePlatformAccount

- (void)sUserBalancePlatformAccountSuccess:(SUserBalancePlatformAccountSuccessBlock)success andFailure:(SUserBalancePlatformAccountFailureBlock)failure {
    [HttpManager postWithUrl:SUserBalancePlatformAccount_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SUserBalancePlatformAccount mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SUserBalancePlatformAccount"};
        }];
        success(dic[@"code"],dic[@"message"],[SUserBalancePlatformAccount mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
