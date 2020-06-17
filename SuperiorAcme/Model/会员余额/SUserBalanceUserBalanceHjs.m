//
//  SUserBalanceUserBalanceHjs.m
//  SuperiorAcme
//
//  Created by GYM on 2018/3/20.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SUserBalanceUserBalanceHjs.h"

@implementation SUserBalanceUserBalanceHjs

- (void)sUserBalanceUserBalanceHjsSuccess:(SUserBalanceUserBalanceHjsSuccessBlock)success andFailure:(SUserBalanceUserBalanceHjsFailureBlock)failure {
    [HttpManager postWithUrl:SUserBalanceUserBalanceHjs_Url andParameters:@{@"pay_status":_pay_status,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SUserBalanceUserBalanceHjs mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SUserBalanceUserBalanceHjs"};
        }];
        success(dic[@"code"],dic[@"message"],[SUserBalanceUserBalanceHjs mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
