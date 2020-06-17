//
//  SPreOrderPreOrderList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SPreOrderPreOrderList.h"

@implementation SPreOrderPreOrderList

- (void)sPreOrderPreOrderListSuccess:(SPreOrderPreOrderListSuccessBlock)success andFailure:(SPreOrderPreOrderListFailureBlock)failure {
    [HttpManager postWithUrl:SPreOrderPreOrderList_Url andParameters:@{@"order_status":_order_status,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SPreOrderPreOrderList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SPreOrderPreOrderList",@"order_goods":@"SPreOrderPreOrderList"};
        }];
        success(dic[@"code"],dic[@"message"],[SPreOrderPreOrderList mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
