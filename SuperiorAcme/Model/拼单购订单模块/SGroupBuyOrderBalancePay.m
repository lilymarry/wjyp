//
//  SGroupBuyOrderBalancePay.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGroupBuyOrderBalancePay.h"

@implementation SGroupBuyOrderBalancePay

- (void)sGroupBuyOrderBalancePaySuccess:(SGroupBuyOrderBalancePaySuccessBlock)success andFailure:(SGroupBuyOrderBalancePayFailureBlock)failure {
    [HttpManager postWithUrl:SGroupBuyOrderBalancePay_Url andParameters:@{@"group_buy_order_id":_group_buy_order_id,@"discount_type":_discount_type} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
