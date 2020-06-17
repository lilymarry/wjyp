//
//  SIntegralOrderOrderList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SIntegralOrderOrderList.h"

@implementation SIntegralOrderOrderList

- (void)sIntegralOrderOrderListSuccess:(SIntegralOrderOrderListSuccessBlock)success andFailure:(SIntegralOrderOrderListFailureBlock)failure {
    [HttpManager postWithUrl:SIntegralOrderOrderList_Url andParameters:@{@"order_status":_order_status,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SIntegralOrderOrderList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SIntegralOrderOrderList"};
        }];
        success(dic[@"code"],dic[@"message"],[SIntegralOrderOrderList mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
