//
//  SGroupBuyOrderDeleteOrder.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGroupBuyOrderDeleteOrder.h"

@implementation SGroupBuyOrderDeleteOrder

- (void)sGroupBuyOrderDeleteOrderSuccess:(SGroupBuyOrderDeleteOrderSuccessBlock)success andFailure:(SGroupBuyOrderDeleteOrderFailureBlock)failure {
    [HttpManager postWithUrl:SGroupBuyOrderDeleteOrder_Url andParameters:@{@"group_buy_order_id":_group_buy_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
