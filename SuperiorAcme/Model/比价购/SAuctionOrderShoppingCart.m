//
//  SAuctionOrderShoppingCart.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAuctionOrderShoppingCart.h"

@implementation SAuctionOrderShoppingCart

- (void)sAuctionOrderShoppingCartSuccess:(SAuctionOrderShoppingCartSuccessBlock)success andFailure:(SAuctionOrderShoppingCartFailureBlock)failure {
    [HttpManager postWithUrl:SAuctionOrderShoppingCart_Url andParameters:@{@"auction_id":_auction_id,@"order_id":_order_id,@"buy_type":_buy_type} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SAuctionOrderShoppingCart mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"item":@"SAuctionOrderShoppingCart"};
        }];
        success(dic[@"code"],dic[@"message"],[SAuctionOrderShoppingCart mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
