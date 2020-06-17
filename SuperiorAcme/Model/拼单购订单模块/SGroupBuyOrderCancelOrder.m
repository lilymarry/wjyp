//
//  SGroupBuyOrderCancelOrder.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGroupBuyOrderCancelOrder.h"

@implementation SGroupBuyOrderCancelOrder

- (void)sGroupBuyOrderCancelOrderSuccess:(SGroupBuyOrderCancelOrderSuccessBlock)success andFailure:(SGroupBuyOrderCancelOrderFailureBlock)failure {
    [HttpManager postWithUrl:SGroupBuyOrderCancelOrder_Url andParameters:@{@"group_buy_order_id":_group_buy_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
