//
//  SIntegralPayIntegralPay.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/14.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SIntegralPayIntegralPay.h"

@implementation SIntegralPayIntegralPay

- (void)sIntegralPayIntegralPaySuccess:(SIntegralPayIntegralPaySuccessBlock)success andFailure:(SIntegralPayIntegralPayFailureBlock)failure {
    [HttpManager postWithUrl:SIntegralPayIntegralPay_Url andParameters:@{@"order_id":_order_id,@"order_type":_order_type,@"auct_id":_auct_id,@"goods_num":_goods_num} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
