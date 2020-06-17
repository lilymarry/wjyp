//
//  SHouseOrderAddOrder.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/30.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SHouseOrderAddOrder.h"

@implementation SHouseOrderAddOrder

- (void)sHouseOrderAddOrderSuccess:(SHouseOrderAddOrderSuccessBlock)success andFailure:(SHouseOrderAddOrderFailureBlock)failure {
    [HttpManager postWithUrl:SHouseOrderAddOrder_Url andParameters:@{@"style_id":_style_id,@"num":_num,@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SHouseOrderAddOrder mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
