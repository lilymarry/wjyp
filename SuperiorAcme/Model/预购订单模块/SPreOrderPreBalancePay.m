//
//  SPreOrderPreBalancePay.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SPreOrderPreBalancePay.h"

@implementation SPreOrderPreBalancePay

- (void)sPreOrderPreBalancePaySuccess:(SPreOrderPreBalancePaySuccessBlock)success andFailure:(SPreOrderPreBalancePayFailureBlock)failure {
    [HttpManager postWithUrl:SPreOrderPreBalancePay_Url andParameters:@{@"order_id":_order_id,@"discount_type":_discount_type} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
