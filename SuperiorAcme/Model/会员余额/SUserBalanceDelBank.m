//
//  SUserBalanceDelBank.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserBalanceDelBank.h"

@implementation SUserBalanceDelBank

- (void)sUserBalanceDelBankSuccess:(SUserBalanceDelBankSuccessBlock)success andFailure:(SUserBalanceDelBankFailureBlock)failure {
    [HttpManager postWithUrl:SUserBalanceDelBank_Url andParameters:@{@"bank_card_id":_bank_card_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
