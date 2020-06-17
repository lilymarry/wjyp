//
//  SCarOrderDeleteOrder.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCarOrderDeleteOrder.h"

@implementation SCarOrderDeleteOrder

- (void)sCarOrderDeleteOrderSuccess:(SCarOrderDeleteOrderSuccessBlock)success andFailure:(SCarOrderDeleteOrderFailureBlock)failure {
    [HttpManager postWithUrl:SCarOrderDeleteOrder_Url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
