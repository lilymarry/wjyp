//
//  SMemberOrderSetOrder.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/31.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SMemberOrderSetOrder.h"

@implementation SMemberOrderSetOrder

- (void)sMemberOrderSetOrderSuccess:(SMemberOrderSetOrderSuccessBlock)success andFailure:(SMemberOrderSetOrderFailureBlock)failure {
    [HttpManager postWithUrl:SMemberOrderSetOrder_Url andParameters:@{@"member_coding":_member_coding,@"number":_number,@"discount_type":_discount_type,@"pay_type":_pay_type,@"order_id":_order_id == nil ? @"" : _order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SMemberOrderSetOrder mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
