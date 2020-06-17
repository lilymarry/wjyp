//
//  SLimitBuyOrderOrderList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SLimitBuyOrderOrderList.h"

@implementation SLimitBuyOrderOrderList

- (void)sLimitBuyOrderOrderListSuccess:(SLimitBuyOrderOrderListSuccessBlock)success andFailure:(SLimitBuyOrderOrderListFailureBlock)failure {
    [HttpManager postWithUrl:SLimitBuyOrderOrderList_Url andParameters:@{@"order_status":_order_status,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SLimitBuyOrderOrderList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SLimitBuyOrderOrderList",@"order_goods":@"SLimitBuyOrderOrderList"};
        }];
        success(dic[@"code"],dic[@"message"],[SLimitBuyOrderOrderList mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
