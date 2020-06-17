//
//  SIntegralOrderSetOrder.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SIntegralOrderSetOrder.h"

@implementation SIntegralOrderSetOrder

- (void)sIntegralOrderSetOrderSuccess:(SIntegralOrderSetOrderSuccessBlock)success andFailure:(SIntegralOrderSetOrderFailureBlock)failure {
    [HttpManager postWithUrl:SIntegralOrderSetOrder_Url andParameters:@{@"goods_num":_goods_num,@"address_id":_address_id,@"integral_id":_integral_id,@"order_id":_order_id,@"order_type":_order_type,@"freight":_freight,@"freight_type":_freight_type} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SIntegralOrderSetOrder mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
