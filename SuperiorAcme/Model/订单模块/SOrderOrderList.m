//
//  SOrderOrderList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/6.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOrderOrderList.h"

@implementation SOrderOrderList

- (void)sOrderOrderListSuccess:(SOrderOrderListSuccessBlock)success andFailure:(SOrderOrderListFailureBlock)failure {
    [HttpManager postWithUrl:SOrderOrderList_Url andParameters:@{@"order_status":_order_status,@"order_type":_order_type,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SOrderOrderList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SOrderOrderList",@"order_goods":@"SOrderOrderList"};
        }];
        success(dic[@"code"],dic[@"message"],[SOrderOrderList mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
