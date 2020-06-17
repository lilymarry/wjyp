//
//  SLimitBuyOrderReceiving.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SLimitBuyOrderReceiving.h"

@implementation SLimitBuyOrderReceiving

- (void)sLimitBuyOrderReceivingSuccess:(SLimitBuyOrderReceivingSuccessBlock)success andFailure:(SLimitBuyOrderReceivingFailureBlock)failure {
    [HttpManager postWithUrl:SLimitBuyOrderReceiving_Url andParameters:@{@"limit_buy_order_id":_limit_buy_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
