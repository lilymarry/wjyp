//
//  SAuctionOrderReceiving.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAuctionOrderReceiving.h"

@implementation SAuctionOrderReceiving

- (void)sAuctionOrderReceivingSuccess:(SAuctionOrderReceivingSuccessBlock)success andFailure:(SAuctionOrderReceivingFailureBlock)failure {
    [HttpManager postWithUrl:SAuctionOrderReceiving_Url andParameters:@{@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
