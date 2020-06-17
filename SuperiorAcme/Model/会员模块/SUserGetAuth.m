//
//  SUserGetAuth.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserGetAuth.h"

@implementation SUserGetAuth

- (void)sUserGetAuthSuccess:(SUserGetAuthSuccessBlock)success andFailure:(SUserGetAuthFailureBlock)failure {
    [HttpManager postWithUrl:SUserGetAuth_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SUserGetAuth mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
