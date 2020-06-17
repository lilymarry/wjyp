//
//  SHouseOrderBalancePay.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/30.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SHouseOrderBalancePay.h"

@implementation SHouseOrderBalancePay

- (void)sHouseOrderBalancePaySuccess:(SHouseOrderBalancePaySuccessBlock)success andFailure:(SHouseOrderBalancePayFailureBlock)failure {
    [HttpManager postWithUrl:SHouseOrderBalancePay_Url andParameters:@{@"order_id":_order_id,@"discount_type":_discount_type} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
