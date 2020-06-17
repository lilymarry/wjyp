//
//  SUserBalanceGetCash.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserBalanceGetCash.h"

@implementation SUserBalanceGetCash

- (void)sUserBalanceGetCashSuccess:(SUserBalanceGetCashSuccessBlock)success andFailure:(SUserBalanceGetCashFailureBlock)failure {
    [HttpManager postWithUrl:SUserBalanceGetCash_Url andParameters:@{@"pay_password":_pay_password,@"money":_money,@"rate":_rate,@"bank_card_id":_bank_card_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
