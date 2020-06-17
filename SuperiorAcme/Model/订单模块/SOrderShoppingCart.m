//
//  SOrderShoppingCart.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/5.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOrderShoppingCart.h"

@implementation SOrderShoppingCart

- (void)sOrderShoppingCartSuccess:(SOrderShoppingCartSuccessBlock)success andFailure:(SOrderShoppingCartFailureBlock)failure {
    [HttpManager postWithUrl:SOrderShoppingCart_Url andParameters:@{@"cart_id":_cart_id,@"merchant_id":_merchant_id,@"p":_p,@"goods":_goods,@"num":_num,@"order_type":_order_type} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SOrderShoppingCart mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"item":@"SOrderShoppingCart"};
        }];
        success(dic[@"code"],dic[@"message"],[SOrderShoppingCart mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
