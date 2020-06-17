//
//  SCarOrderIntegralPay.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCarOrderIntegralPay.h"

@implementation SCarOrderIntegralPay

- (void)sCarOrderIntegralPaySuccess:(SCarOrderIntegralPaySuccessBlock)success andFailure:(SCarOrderIntegralPayFailureBlock)failure {
    [HttpManager postWithUrl:SCarOrderIntegralPay_Url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
