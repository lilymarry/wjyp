//
//  SIntegralBuyOrderShoppingCart.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/18.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SIntegralBuyOrderShoppingCart.h"

@implementation SIntegralBuyOrderShoppingCart

- (void)sIntegralBuyOrderShoppingCartSuccess:(SIntegralBuyOrderShoppingCartSuccessBlock)success andFailure:(SIntegralBuyOrderShoppingCartFailureBlock)failure {
    [HttpManager postWithUrl:SIntegralBuyOrderShoppingCart_Url andParameters:@{@"merchant_id":_merchant_id,@"integralBuy_id":_integralBuy_id,@"num":_num} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SIntegralBuyOrderShoppingCart mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"item":@"SIntegralBuyOrderShoppingCart"};
        }];
        success(dic[@"code"],dic[@"message"],[SIntegralBuyOrderShoppingCart mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
