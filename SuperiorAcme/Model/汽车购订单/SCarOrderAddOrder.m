//
//  SCarOrderAddOrder.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/28.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCarOrderAddOrder.h"

@implementation SCarOrderAddOrder

- (void)sCarOrderAddOrderSuccess:(SCarOrderAddOrderSuccessBlock)success andFailure:(SCarOrderAddOrderFailureBlock)failure {
    [HttpManager postWithUrl:SCarOrderAddOrder_Url andParameters:@{@"car_id":_car_id,@"num":_num,@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SCarOrderAddOrder mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
