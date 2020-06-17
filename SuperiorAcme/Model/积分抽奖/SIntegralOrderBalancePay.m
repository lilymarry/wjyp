//
//  SIntegralOrderBalancePay.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SIntegralOrderBalancePay.h"

@implementation SIntegralOrderBalancePay

- (void)sIntegralOrderBalancePaySuccess:(SIntegralOrderBalancePaySuccessBlock)success andFailure:(SIntegralOrderBalancePayFailureBlock)failure {
    [HttpManager postWithUrl:SIntegralOrderBalancePay_Url andParameters:@{@"pay_type":_pay_type} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
