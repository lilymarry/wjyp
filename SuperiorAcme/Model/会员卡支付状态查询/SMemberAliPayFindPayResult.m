//
//  SMemberAliPayFindPayResult.m
//  SuperiorAcme
//
//  Created by GYM on 2018/2/1.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SMemberAliPayFindPayResult.h"

@implementation SMemberAliPayFindPayResult

- (void)sMemberAliPayFindPayResultSuccess:(SMemberAliPayFindPayResultSuccessBlock)success andFailure:(SMemberAliPayFindPayResultFailureBlock)failure {
    [HttpManager postWithUrl:SMemberAliPayFindPayResult_Url andParameters:@{@"order_id":_order_id,@"type":_type} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
