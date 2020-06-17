//
//  SAuctionOrderCancelOrder.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAuctionOrderCancelOrder.h"

@implementation SAuctionOrderCancelOrder

- (void)sAuctionOrderCancelOrderSuccess:(SAuctionOrderCancelOrderSuccessBlock)success andFailure:(SAuctionOrderCancelOrderFailureBlock)failure {
    [HttpManager postWithUrl:SAuctionOrderCancelOrder_Url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
