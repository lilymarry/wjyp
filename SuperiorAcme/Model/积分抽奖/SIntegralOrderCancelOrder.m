//
//  SIntegralOrderCancelOrder.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SIntegralOrderCancelOrder.h"

@implementation SIntegralOrderCancelOrder

- (void)sIntegralOrderCancelOrderSuccess:(SIntegralOrderCancelOrderSuccessBlock)success andFailure:(SIntegralOrderCancelOrderFailureBlock)failure {
    [HttpManager postWithUrl:SIntegralOrderCancelOrder_Url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
