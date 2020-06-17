//
//  SIntegralBuyOrderReceiving.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/18.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SIntegralBuyOrderReceiving.h"

@implementation SIntegralBuyOrderReceiving

- (void)sIntegralBuyOrderReceivingSuccess:(SIntegralBuyOrderReceivingSuccessBlock)success andFailure:(SIntegralBuyOrderReceivingFailureBlock)failure {
    [HttpManager postWithUrl:SIntegralBuyOrderReceiving_Url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
