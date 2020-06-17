//
//  SIntegralOrderDetails.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SIntegralOrderDetails.h"

@implementation SIntegralOrderDetails

- (void)sIntegralOrderDetailsSuccess:(SIntegralOrderDetailsSuccessBlock)success andFailure:(SIntegralOrderDetailsFailureBlock)failure {
    [HttpManager postWithUrl:SIntegralOrderDetails_Url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SIntegralOrderDetails mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"number":@"SIntegralOrderDetails"};
        }];
        success(dic[@"code"],dic[@"message"],[SIntegralOrderDetails mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
