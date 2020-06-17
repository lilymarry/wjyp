//
//  SAuctionOrderDeleteOrder.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAuctionOrderDeleteOrder.h"

@implementation SAuctionOrderDeleteOrder

- (void)sAuctionOrderDeleteOrderSuccess:(SAuctionOrderDeleteOrderSuccessBlock)success andFailure:(SAuctionOrderDeleteOrderFailureBlock)failure {
    [HttpManager postWithUrl:SAuctionOrderDeleteOrder_Url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"message"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
