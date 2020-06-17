//
//  SPreOrderPreCancelOrder.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SPreOrderPreCancelOrder.h"

@implementation SPreOrderPreCancelOrder

- (void)sPreOrderPreCancelOrderSuccess:(SPreOrderPreCancelOrderSuccessBlock)success andFailure:(SPreOrderPreCancelOrderFailureBlock)failure {
    [HttpManager postWithUrl:SPreOrderPreCancelOrder_Url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
