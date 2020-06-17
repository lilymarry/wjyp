//
//  SAuctionAuctionIndex.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAuctionAuctionIndex.h"

@implementation SAuctionAuctionIndex

- (void)sAuctionAuctionIndexSuccess:(SAuctionAuctionIndexSuccessBlock)success andFailure:(SAuctionAuctionIndexFailureBlock)failure {
    [HttpManager postWithUrl:SAuctionAuctionIndex_Url andParameters:@{@"next":_next,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SAuctionAuctionIndex mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"auction_list":@"SAuctionAuctionIndex"};
        }];
        success(dic[@"code"],dic[@"message"],[SAuctionAuctionIndex mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
