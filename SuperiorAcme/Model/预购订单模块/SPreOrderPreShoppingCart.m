//
//  SPreOrderPreShoppingCart.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SPreOrderPreShoppingCart.h"

@implementation SPreOrderPreShoppingCart

- (void)sPreOrderPreShoppingCartSuccess:(SPreOrderPreShoppingCartSuccessBlock)success andFailure:(SPreOrderPreShoppingCartFailureBlock)failure {
    [HttpManager postWithUrl:SPreOrderPreShoppingCart_Url andParameters:@{@"pre_id":_pre_id,@"num":_num,@"order_type":_order_type} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SPreOrderPreShoppingCart mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"item":@"SPreOrderPreShoppingCart"};
        }];
        success(dic[@"code"],dic[@"message"],[SPreOrderPreShoppingCart mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
