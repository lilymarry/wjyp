//
//  SPayGetHjsp.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/25.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SPayGetHjsp.h"

@implementation SPayGetHjsp

- (void)sPayGetHjspSuccess:(SPayGetHjspSuccessBlock)success andFailure:(SPayGetHjspFailureBlock)failure {
    [HttpManager postWithUrl:SPayGetHjsp_Url andParameters:@{@"totalPrice":_totalPrice,@"order_id":_order_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SPayGetHjsp mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
