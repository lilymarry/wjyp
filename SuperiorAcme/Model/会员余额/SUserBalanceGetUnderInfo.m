//
//  SUserBalanceGetUnderInfo.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/23.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserBalanceGetUnderInfo.h"

@implementation SUserBalanceGetUnderInfo

- (void)sUserBalanceGetUnderInfoSuccess:(SUserBalanceGetUnderInfoSuccessBlock)success andFailure:(SUserBalanceGetUnderInfoFailureBlock)failure {
    [HttpManager postWithUrl:SUserBalanceGetUnderInfo_Url andParameters:@{@"act_id":_act_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SUserBalanceGetUnderInfo mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
