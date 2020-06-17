//
//  SLimitBuyOrderShoppingCart.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SLimitBuyOrderShoppingCart.h"

@implementation SLimitBuyOrderShoppingCart

- (void)sLimitBuyOrderShoppingCartSuccess:(SLimitBuyOrderShoppingCartSuccessBlock)success andFailure:(SLimitBuyOrderShoppingCartFailureBlock)failure {
    [HttpManager postWithUrl:SLimitBuyOrderShoppingCart_Url andParameters:@{@"goods_id":_goods_id,@"num":_num,@"product_id":_product_id,@"merchant_id":_merchant_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SLimitBuyOrderShoppingCart mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"item":@"SLimitBuyOrderShoppingCart"};
        }];
        success(dic[@"code"],dic[@"message"],[SLimitBuyOrderShoppingCart mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
