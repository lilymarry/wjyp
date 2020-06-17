//
//  SIntegralOrderReceiving.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SIntegralOrderReceiving.h"

@implementation SIntegralOrderReceiving

- (void)sIntegralOrderReceivingSuccess:(SIntegralOrderReceivingSuccessBlock)success andFailure:(SIntegralOrderReceivingFailureBlock)failure {
    [HttpManager postWithUrl:SIntegralOrderReceiving_Url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
