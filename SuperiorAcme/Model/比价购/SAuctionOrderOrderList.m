//
//  SAuctionOrderOrderList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAuctionOrderOrderList.h"

@implementation SAuctionOrderOrderList

- (void)sAuctionOrderOrderListSuccess:(SAuctionOrderOrderListSuccessBlock)success andFailure:(SAuctionOrderOrderListFailureBlock)failure {
    [HttpManager postWithUrl:SAuctionOrderOrderList_Url andParameters:@{@"order_status":_order_status,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SAuctionOrderOrderList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SAuctionOrderOrderList",@"order_goods":@"SAuctionOrderOrderList"};
        }];
        success(dic[@"code"],dic[@"message"],[SAuctionOrderOrderList mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
