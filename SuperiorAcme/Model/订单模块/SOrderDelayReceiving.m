//
//  SOrderDelayReceiving.m
//  SuperiorAcme
//
//  Created by GYM on 2018/2/13.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SOrderDelayReceiving.h"

@implementation SOrderDelayReceiving

- (void)sOrderDelayReceivingSuccess:(SOrderDelayReceivingSuccessBlock)success andFailure:(SOrderDelayReceivingFailureBlock)failure {
    
    NSString * URLString = nil;
    if ([_orderType isEqualToString:@"普通商品"]) {
        URLString = SOrderDelayReceiving_Url;//普通商品订单的延长
    }else if ([_orderType isEqualToString:@"拼单购"]){
        URLString = SGroupBuyOrderDelayReceiving_Url;//拼团商品订单的延长
    }else if ([_orderType isEqualToString:@"无界商店"]){
        URLString = SIntegralBuyDelayReceiving_Url;//拼团商品订单的延长
    }
    
    [HttpManager postWithUrl:URLString andParameters:@{@"order_goods_id":_order_goods_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
    
//    [HttpManager postWithUrl:SOrderDelayReceiving_Url andParameters:@{@"order_goods_id":_order_goods_id} andSuccess:^(id Json) {
//        NSDictionary * dic = (NSDictionary *)Json;
//        success(dic[@"code"],dic[@"message"]);
//    } andFail:^(NSError *error) {
//        failure(error);
//    }];
}
@end
