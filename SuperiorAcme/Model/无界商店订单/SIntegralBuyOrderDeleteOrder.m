//
//  SIntegralBuyOrderDeleteOrder.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/18.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SIntegralBuyOrderDeleteOrder.h"

@implementation SIntegralBuyOrderDeleteOrder

- (void)sIntegralBuyOrderDeleteOrderSuccess:(SIntegralBuyOrderDeleteOrderSuccessBlock)success andFailure:(SIntegralBuyOrderDeleteOrderFailureBlock)failure {
    [HttpManager postWithUrl:SIntegralBuyOrderDeleteOrder_Url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
