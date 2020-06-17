//
//  SOrderDeleteOrder.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/6.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOrderDeleteOrder.h"

@implementation SOrderDeleteOrder

- (void)sOrderDeleteOrderSuccess:(SOrderDeleteOrderSuccessBlock)success andFailure:(SOrderDeleteOrderFailureBlock)failure {
    [HttpManager postWithUrl:SOrderDeleteOrder_Url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
