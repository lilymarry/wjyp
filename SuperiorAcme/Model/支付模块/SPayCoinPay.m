//
//  SPayCoinPay.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/1/9.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "SPayCoinPay.h"

@implementation SPayCoinPay
- (void)SPayCoinPayPaySuccess:(SPayCoinPayPaySuccessBlock)success andFailure:(SPayCoinPayPayFailureBlock)failure
{
    [HttpManager postWithUrl:@"Pay/coinPay" andParameters:@{@"order_id":_order_id,@"order_type":_order_type} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
