//
//  SIntegralBuyOrderSetOrder.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/18.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SIntegralBuyOrderSetOrder.h"

@implementation SIntegralBuyOrderSetOrder

- (void)sIntegralBuyOrderSetOrderSuccess:(SIntegralBuyOrderSetOrderSuccessBlock)success andFailure:(SIntegralBuyOrderSetOrderFailureBlock)failure {
    [HttpManager postWithUrl:SIntegralBuyOrderSetOrder_Url andParameters:@{@"integralBuy_id":_integralBuy_id,@"address_id":_address_id,@"goods_num":_goods_num,@"order_id":_order_id,@"freight":_freight,@"freight_type":_freight_type,@"invoice":_invoice,@"leave_message":_leave_message,@"shipping_id":_shipping_id == nil ? @"" : _shipping_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SIntegralBuyOrderSetOrder mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
