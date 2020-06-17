//
//  SOrderCancelOrder.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/6.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOrderCancelOrder.h"

@implementation SOrderCancelOrder

- (void)sOrderCancelOrderSuccess:(SOrderCancelOrderSuccessBlock)success andFailure:(SOrderCancelOrderFailureBlock)failure {
    
    NSString *urlString = @"";
    NSMutableDictionary *para = [NSMutableDictionary dictionary];
    if([_order_type isEqualToString:@"无界商店"]){
        urlString = SIntegralBuyOrderCancelOrder_Url;
    }else{
        urlString = SOrderCancelOrder_Url;
    }
    
    [para setValue:_order_id forKey:@"order_id"];
    
    [HttpManager postWithUrl:urlString andParameters:para andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
