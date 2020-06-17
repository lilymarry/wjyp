//
//  SIntegralBuyOrderCancelOrder.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/18.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SIntegralBuyOrderCancelOrder.h"

@implementation SIntegralBuyOrderCancelOrder

- (void)sIntegralBuyOrderCancelOrderSuccess:(SIntegralBuyOrderCancelOrderSuccessBlock)success andFailure:(SIntegralBuyOrderCancelOrderFailureBlock)failure {
    [HttpManager postWithUrl:SIntegralBuyOrderCancelOrder_Url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
