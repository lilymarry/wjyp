//
//  SUserBalanceSearchBank.m
//  SuperiorAcme
//
//  Created by GYM on 2018/4/11.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SUserBalanceSearchBank.h"

@implementation SUserBalanceSearchBank

- (void)sUserBalanceSearchBankSuccess:(SUserBalanceSearchBankSuccessBlock)success andFailure:(SUserBalanceSearchBankFailureBlock)failure {
    [HttpManager postWithUrl:SUserBalanceSearchBank_Url andParameters:@{@"bank_name":_bank_name} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SUserBalanceSearchBank mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SUserBalanceSearchBank"};
        }];
        success(dic[@"code"],dic[@"message"],[SUserBalanceSearchBank mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
