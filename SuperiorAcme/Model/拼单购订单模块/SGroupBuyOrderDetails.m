//
//  SGroupBuyOrderDetails.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGroupBuyOrderDetails.h"

@implementation SGroupBuyOrderDetails

- (void)sGroupBuyOrderDetailsSuccess:(SGroupBuyOrderDetailsSuccessBlock)success andFailure:(SGroupBuyOrderDetailsFailureBlock)failure {
    [HttpManager postWithUrl:SGroupBuyOrderDetails_Url andParameters:@{@"group_buy_order_id":_group_buy_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SGroupBuyOrderDetails mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"list":@"SGroupBuyOrderDetails"};
        }];
        success(dic[@"code"],dic[@"message"],[SGroupBuyOrderDetails mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
