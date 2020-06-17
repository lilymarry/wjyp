//
//  SIntegralOrderDeleteOrder.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SIntegralOrderDeleteOrder.h"

@implementation SIntegralOrderDeleteOrder

- (void)sIntegralOrderDeleteOrderSuccess:(SIntegralOrderDeleteOrderSuccessBlock)success andFailure:(SIntegralOrderDeleteOrderFailureBlock)failure {
    [HttpManager postWithUrl:SIntegralOrderDeleteOrder_Url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
