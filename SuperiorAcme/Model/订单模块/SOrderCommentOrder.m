//
//  SOrderCommentOrder.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/7.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOrderCommentOrder.h"

@implementation SOrderCommentOrder

- (void)sOrderCommentOrderSuccess:(SOrderCommentOrderSuccessBlock)success andFailure:(SOrderCommentOrderFailureBlock)failure {
    [HttpManager postWithUrl:SOrderCommentOrder_Url andParameters:@{@"order_id":_order_id,@"merchant_star":_merchant_star,@"delivery_star":_delivery_star,@"order_type":_order_type} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
