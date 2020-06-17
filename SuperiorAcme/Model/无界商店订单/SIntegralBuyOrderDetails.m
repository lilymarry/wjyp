//
//  SIntegralBuyOrderDetails.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/18.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SIntegralBuyOrderDetails.h"

@implementation SIntegralBuyOrderDetails

- (void)sIntegralBuyOrderDetailsSuccess:(SIntegralBuyOrderDetailsSuccessBlock)success andFailure:(SIntegralBuyOrderDetailsFailureBlock)failure {
    [HttpManager postWithUrl:SIntegralBuyOrderDetails_Url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SIntegralBuyOrderDetails mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"list":@"SIntegralBuyOrderDetails"};
        }];
        success(dic[@"code"],dic[@"message"],[SIntegralBuyOrderDetails mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
