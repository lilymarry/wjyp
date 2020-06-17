//
//  SOrderRemind.m
//  SuperiorAcme
//
//  Created by GYM on 2018/3/21.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SOrderRemind.h"

@implementation SOrderRemind

- (void)sOrderRemindSuccess:(SOrderRemindSuccessBlock)success andFailure:(SOrderRemindFailureBlock)failure {
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    NSString * URLString = nil;
    NSString *baseurl=Base_url;
    if ([_orderType isEqualToString:@"普通商品"]) {
        [dict setValue:_order_goods_id forKey:@"order_goods_id"];
        URLString = SOrderRemind_Url;
    }else if ([_orderType isEqualToString:@"拼单购"]){
        [dict setValue:_group_buy_order_id forKey:@"group_buy_order_id"];
        URLString = SGroupBuyOrderRemind_Url;
    }else if ([_orderType isEqualToString:@"无界商店"]){
        [dict setValue:_order_id forKey:@"order_id"];
        URLString = IntegralBuyOrderRemind_Url;
    }
    else if ([_orderType isEqualToString:@"赠品专区"]){
        [dict setValue:_order_id forKey:@"order_id"];
        URLString = @"GiftGoodsOrder/remind";
        baseurl=SgiftBase_url;
    }
    
    [HttpManager postSgiftWithUrl:URLString baseurl:baseurl andParameters:dict andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
    
//    [HttpManager postWithUrl:SOrderRemind_Url andParameters:@{@"order_goods_id":_order_goods_id} andSuccess:^(id Json) {
//        NSDictionary * dic = (NSDictionary *)Json;
//        success(dic[@"code"],dic[@"message"]);
//    } andFail:^(NSError *error) {
//        failure(error);
//    }];
}
@end
