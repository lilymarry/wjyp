//
//  SAuctionOrderSetOrder.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAuctionOrderSetOrder.h"

@implementation SAuctionOrderSetOrder

- (void)sAuctionOrderSetOrderSuccess:(SAuctionOrderSetOrderSuccessBlock)success andFailure:(SAuctionOrderSetOrderFailureBlock)failure {
    [HttpManager postWithUrl:SAuctionOrderSetOrder_Url andParameters:@{@"address_id":_address_id,@"auction_id":_auction_id,@"buy_type":_buy_type,@"bid":_bid,@"order_id":_order_id,@"freight":_freight,@"freight_type":_freight_type} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SAuctionOrderSetOrder mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
