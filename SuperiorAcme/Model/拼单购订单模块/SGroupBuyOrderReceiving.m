//
//  SGroupBuyOrderReceiving.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGroupBuyOrderReceiving.h"

@implementation SGroupBuyOrderReceiving

- (void)sGroupBuyOrderReceivingSuccess:(SGroupBuyOrderReceivingSuccessBlock)success andFailure:(SGroupBuyOrderReceivingFailureBlock)failure {
    [HttpManager postWithUrl:SGroupBuyOrderReceiving_Url andParameters:@{@"group_buy_order_id":_group_buy_order_id,@"status":_status ?: @""} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
