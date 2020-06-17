//
//  SUserBalanceBankList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserBalanceBankList.h"

@implementation SUserBalanceBankList

- (void)sUserBalanceBankListSuccess:(SUserBalanceBankListSuccessBlock)success andFailure:(SUserBalanceBankListFailureBlock)failure {
    [HttpManager postWithUrl:SUserBalanceBankList_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SUserBalanceBankList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SUserBalanceBankList"};
        }];
        success(dic[@"code"],dic[@"message"],[SUserBalanceBankList mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
