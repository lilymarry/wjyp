//
//  SBalancePayBalancePay.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SBalancePayBalancePay.h"

@implementation SBalancePayBalancePay

- (void)sBalancePayBalancePaySuccess:(SBalancePayBalancePaySuccessBlock)success andFailure:(SBalancePayBalancePayFailureBlock)failure {
    NSDictionary *dic=@{@"order_id":_order_id,@"order_type":_order_type,@"discount_type":_discount_type,@"goods_num":_goods_num};
    [HttpManager postWithUrl:SBalancePayBalancePay_Url andParameters:dic andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
