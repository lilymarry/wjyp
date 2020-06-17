//
//  SHouseOrderCancelOrder.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SHouseOrderCancelOrder.h"

@implementation SHouseOrderCancelOrder

- (void)sHouseOrderCancelOrderSuccess:(SHouseOrderCancelOrderSuccessBlock)success andFailure:(SHouseOrderCancelOrderFailureBlock)failure {
    [HttpManager postWithUrl:SHouseOrderCancelOrder_Url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
