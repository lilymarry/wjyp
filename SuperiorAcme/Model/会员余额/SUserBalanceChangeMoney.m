//
//  SUserBalanceChangeMoney.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserBalanceChangeMoney.h"

@implementation SUserBalanceChangeMoney

- (void)sUserBalanceChangeMoneySuccess:(SUserBalanceChangeMoneySuccessBlock)success andFailure:(SUserBalanceChangeMoneyFailureBlock)failure {
    [HttpManager postWithUrl:SUserBalanceChangeMoney_Url andParameters:@{@"code":_code,@"money":_money,@"real_name":_real_name,@"pay_password":_pay_password} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
