//
//  SGroupBuyOrderShoppingCart.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGroupBuyOrderShoppingCart.h"

@implementation SGroupBuyOrderShoppingCart

- (void)sGroupBuyOrderShoppingCartSuccess:(SGroupBuyOrderShoppingCartSuccessBlock)success andFailure:(SGroupBuyOrderShoppingCartFailureBlock)failure {
    [HttpManager postWithUrl:SGroupBuyOrderShoppingCart_Url andParameters:@{@"goods_id":_goods_id,@"num":_num,@"order_type":_order_type,@"product_id":_product_id,@"merchant_id":_merchant_id,@"group_buy_id":_group_buy_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SGroupBuyOrderShoppingCart mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"item":@"SGroupBuyOrderShoppingCart"};
        }];
        success(dic[@"code"],dic[@"message"],[SGroupBuyOrderShoppingCart mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
