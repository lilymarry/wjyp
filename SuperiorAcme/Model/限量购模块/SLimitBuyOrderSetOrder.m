//
//  SLimitBuyOrderSetOrder.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SLimitBuyOrderSetOrder.h"

@implementation SLimitBuyOrderSetOrder

- (void)sLimitBuyOrderSetOrderSuccess:(SLimitBuyOrderSetOrderSuccessBlock)success andFailure:(SLimitBuyOrderSetOrderFailureBlock)failure {
    [HttpManager postWithUrl:SLimitBuyOrderSetOrder_Url andParameters:@{@"limit_buy_id":_limit_buy_id,@"goods_id":_goods_id,@"goods_num":_goods_num,@"product_id":_product_id,@"address_id":_address_id,@"limit_buy_order_id":_limit_buy_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SLimitBuyOrderSetOrder mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
