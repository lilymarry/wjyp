//
//  SAuctionOrderAuct.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/14.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAuctionOrderAuct.h"

@implementation SAuctionOrderAuct

- (void)sAuctionOrderAuctSuccess:(SAuctionOrderAuctSuccessBlock)success andFailure:(SAuctionOrderAuctFailureBlock)failure {
    [HttpManager postWithUrl:SAuctionOrderAuct_Url andParameters:@{@"auction_id":_auction_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SAuctionOrderAuct mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
