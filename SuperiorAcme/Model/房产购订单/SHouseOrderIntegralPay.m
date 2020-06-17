//
//  SHouseOrderIntegralPay.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/30.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SHouseOrderIntegralPay.h"

@implementation SHouseOrderIntegralPay

- (void)sHouseOrderIntegralPaySuccess:(SHouseOrderIntegralPaySuccessBlock)success andFailure:(SHouseOrderIntegralPayFailureBlock)failure {
    [HttpManager postWithUrl:SHouseOrderIntegralPay_Url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
