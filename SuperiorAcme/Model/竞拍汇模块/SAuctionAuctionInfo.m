//
//  SAuctionAuctionInfo.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAuctionAuctionInfo.h"

@implementation SAuctionAuctionInfo

- (void)sAuctionAuctionInfoSuccess:(SAuctionAuctionInfoSuccessBlock)success andFailure:(SAuctionAuctionInfoFailureBlock)failure {
    [HttpManager postWithUrl:SAuctionAuctionInfo_Url andParameters:@{@"auction_id":_auction_id,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SAuctionAuctionInfo mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"goods_active":@"SAuctionAuctionInfo",@"dj_ticket":@"SAuctionAuctionInfo",@"goods_price_desc":@"SAuctionAuctionInfo",@"promotion":@"SAuctionAuctionInfo",@"ticketList":@"SAuctionAuctionInfo",@"goods_common_attr":@"SAuctionAuctionInfo",@"goods_attr":@"SAuctionAuctionInfo",@"attr_list":@"goods_common_attr",@"goods_banner":@"SAuctionAuctionInfo",@"pictures":@"SAuctionAuctionInfo",@"goods_server":@"SAuctionAuctionInfo",@"auction_log":@"SAuctionAuctionInfo",@"guess_goods_list":@"SAuctionAuctionInfo"};
        }];
        success(dic[@"code"],dic[@"message"],[SAuctionAuctionInfo mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
