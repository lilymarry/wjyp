//
//  SCarOrderCancelOrder.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCarOrderCancelOrder.h"

@implementation SCarOrderCancelOrder

- (void)sCarOrderCancelOrderSuccess:(SCarOrderCancelOrderSuccessBlock)success andFailure:(SCarOrderCancelOrderFailureBlock)failure {
    [HttpManager postWithUrl:SCarOrderCancelOrder_Url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
