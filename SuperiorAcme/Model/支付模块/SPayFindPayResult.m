//
//  SPayFindPayResult.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SPayFindPayResult.h"

@implementation SPayFindPayResult

- (void)sPayFindPayResultSuccess:(SPayFindPayResultSuccessBlock)success andFailure:(SPayFindPayResultFailureBlock)failure {
    [HttpManager postWithUrl:SPayFindPayResult_Url andParameters:@{@"order_id":_order_id,@"type":_type} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SPayFindPayResult mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
