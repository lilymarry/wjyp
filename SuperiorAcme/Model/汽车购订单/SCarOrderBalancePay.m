//
//  SCarOrderBalancePay.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCarOrderBalancePay.h"

@implementation SCarOrderBalancePay

- (void)sCarOrderBalancePaySuccess:(SCarOrderBalancePaySuccessBlock)success andFailure:(SCarOrderBalancePayFailureBlock)failure {
    [HttpManager postWithUrl:SCarOrderBalancePay_Url andParameters:@{@"order_id":_order_id,@"discount_type":_discount_type} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
