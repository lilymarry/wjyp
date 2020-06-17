//
//  SAfterSaleBackApplyType.m
//  SuperiorAcme
//
//  Created by GYM on 2018/2/13.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SAfterSaleBackApplyType.h"

@implementation SAfterSaleBackApplyType

- (void)sAfterSaleBackApplyTypeSuccess:(SAfterSaleBackApplyTypeSuccessBlock)success andFailure:(SAfterSaleBackApplyTypeFailureBlock)failure {
    [HttpManager postWithUrl:SAfterSaleBackApplyType_Url andParameters:@{@"order_goods_id":_order_goods_id, @"order_type":_order_type} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SAfterSaleBackApplyType mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"list":@"SAfterSaleBackApplyType",@"goods_status":@"SAfterSaleBackApplyType"};
        }];
        success(dic[@"code"],dic[@"message"],[SAfterSaleBackApplyType mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
