//
//  SIntegralBuyOrderOrderList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/18.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SIntegralBuyOrderOrderList.h"

@implementation SIntegralBuyOrderOrderList

- (void)sIntegralBuyOrderOrderListSuccess:(SIntegralBuyOrderOrderListSuccessBlock)success andFailure:(SIntegralBuyOrderOrderListFailureBlock)failure {
    [HttpManager postWithUrl:SIntegralBuyOrderOrderList_Url andParameters:@{@"order_status":_order_status,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SIntegralBuyOrderOrderList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SIntegralBuyOrderOrderList",@"order_goods":@"SIntegralBuyOrderOrderList"};
        }];
        success(dic[@"code"],dic[@"message"],[SIntegralBuyOrderOrderList mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
