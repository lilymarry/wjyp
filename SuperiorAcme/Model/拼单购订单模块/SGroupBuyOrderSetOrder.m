//
//  SGroupBuyOrderSetOrder.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/7.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGroupBuyOrderSetOrder.h"

@implementation SGroupBuyOrderSetOrder

- (void)sGroupBuyOrderSetOrderSuccess:(SGroupBuyOrderSetOrderSuccessBlock)success andFailure:(SGroupBuyOrderSetOrderFailureBlock)failure {
    [HttpManager postWithUrl:SGroupBuyOrderSetOrder_Url andParameters:@{@"address_id":_address_id,@"goods_num":_goods_num,@"goods_id":_goods_id,@"product_id":_product_id,@"order_type":_order_type,@"group_buy_order_id":_group_buy_order_id,@"group_buy_id":_group_buy_id,@"freight":_freight,@"freight_type":_freight_type,@"invoice":_invoice,@"leave_message":_leave_message,@"shipping_id":_shipping_id == nil ? @"" : _shipping_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SGroupBuyOrderSetOrder mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
