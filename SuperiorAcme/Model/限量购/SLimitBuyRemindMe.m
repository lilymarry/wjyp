//
//  SLimitBuyRemindMe.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SLimitBuyRemindMe.h"

@implementation SLimitBuyRemindMe

- (void)sLimitBuyRemindMeSuccess:(SLimitBuyRemindMeSuccessBlock)success andFailure:(SLimitBuyRemindMeFailureBlock)failure {
    [HttpManager postWithUrl:SLimitBuyRemindMe_Url andParameters:@{@"limit_buy_id":_limit_buy_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
