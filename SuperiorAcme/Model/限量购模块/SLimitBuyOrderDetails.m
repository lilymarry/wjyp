//
//  SLimitBuyOrderDetails.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SLimitBuyOrderDetails.h"

@implementation SLimitBuyOrderDetails

- (void)SLimitBuyOrderDetailsSuccess:(SLimitBuyOrderDetailsSuccessBlock)success andFailure:(SLimitBuyOrderDetailsFailureBlock)failure {
    [HttpManager postWithUrl:SLimitBuyOrderDetails_Url andParameters:@{@"limit_buy_order_id":_limit_buy_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SLimitBuyOrderDetails mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"list":@"SLimitBuyOrderDetails"};
        }];
        success(dic[@"code"],dic[@"message"],[SLimitBuyOrderDetails mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
