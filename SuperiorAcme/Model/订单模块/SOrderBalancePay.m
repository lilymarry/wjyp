//
//  SOrderBalancePay.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/6.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOrderBalancePay.h"

@implementation SOrderBalancePay

- (void)sOrderBalancePaySuccess:(SOrderBalancePaySuccessBlock)success andFailure:(SOrderBalancePayFailureBlock)failure {
    [HttpManager postWithUrl:SOrderBalancePay_Url andParameters:@{@"order_id":_order_id,@"discount_type":_discount_type} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
