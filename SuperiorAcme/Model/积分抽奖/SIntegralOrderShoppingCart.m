//
//  SIntegralOrderShoppingCart.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SIntegralOrderShoppingCart.h"

@implementation SIntegralOrderShoppingCart

- (void)sIntegralOrderShoppingCartSuccess:(SIntegralOrderShoppingCartSuccessBlock)success andFailure:(SIntegralOrderShoppingCartFailureBlock)failure {
    [HttpManager postWithUrl:SIntegralOrderShoppingCart_Url andParameters:@{@"merchant_id":_merchant_id,@"num":_num,@"integral_id":_integral_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SIntegralOrderShoppingCart mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"item":@"SIntegralOrderShoppingCart"};
        }];
        success(dic[@"code"],dic[@"message"],[SIntegralOrderShoppingCart mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
