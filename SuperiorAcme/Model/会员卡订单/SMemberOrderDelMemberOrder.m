//
//  SMemberOrderDelMemberOrder.m
//  SuperiorAcme
//
//  Created by GYM on 2018/3/13.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SMemberOrderDelMemberOrder.h"

@implementation SMemberOrderDelMemberOrder

- (void)sMemberOrderDelMemberOrderSuccess:(SMemberOrderDelMemberOrderSuccessBlock)success andFailure:(SMemberOrderDelMemberOrderFailureBlock)failure {
    [HttpManager postWithUrl:SMemberOrderDelMemberOrder_Url andParameters:@{@"order_id":_order_id,@"order_status":_order_status} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
