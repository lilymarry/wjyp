//
//  SUserBalanceUpMoney.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserBalanceUpMoney.h"

@implementation SUserBalanceUpMoney

- (void)sUserBalanceUpMoneySuccess:(SUserBalanceUpMoneySuccessBlock)success andFailure:(SUserBalanceUpMoneyFailureBlock)failure {
    [HttpManager postWithUrl:SUserBalanceUpMoney_Url andParameters:@{@"money":_money,@"pay_type":_pay_type,@"note":_note,@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SUserBalanceUpMoney mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
