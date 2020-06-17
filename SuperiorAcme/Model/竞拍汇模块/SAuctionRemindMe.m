//
//  SAuctionRemindMe.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAuctionRemindMe.h"

@implementation SAuctionRemindMe

- (void)sAuctionRemindMeSuccess:(SAuctionRemindMeSuccessBlock)success andFailure:(SAuctionRemindMeFailureBlock)failure {
    [HttpManager postWithUrl:SAuctionRemindMe_Url andParameters:@{@"auction_id":_auction_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
