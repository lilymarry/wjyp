//
//  SGroupBuyOrderOrderList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGroupBuyOrderOrderList.h"

@implementation SGroupBuyOrderOrderList

- (void)sGroupBuyOrderOrderListSuccess:(SGroupBuyOrderOrderListSuccessBlock)success andFailure:(SGroupBuyOrderOrderListFailureBlock)failure {
    [HttpManager postWithUrl:SGroupBuyOrderOrderList_Url andParameters:@{@"order_status":_order_status,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SGroupBuyOrderOrderList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SGroupBuyOrderOrderList",@"order_goods":@"SGroupBuyOrderOrderList"};
        }];
        success(dic[@"code"],dic[@"message"],[SGroupBuyOrderOrderList mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
