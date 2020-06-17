//
//  SUserBalanceBalanceIndex.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserBalanceBalanceIndex.h"

@implementation SUserBalanceBalanceIndex

- (void)sUserBalanceBalanceIndexSuccess:(SUserBalanceBalanceIndexSuccessBlock)success andFailure:(SUserBalanceBalanceIndexFailureBlock)failure {
    [HttpManager postWithUrl:SUserBalanceBalanceIndex_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SUserBalanceBalanceIndex mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
