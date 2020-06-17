//
//  SUserPersonalAuthInfo.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserPersonalAuthInfo.h"

@implementation SUserPersonalAuthInfo

- (void)sUserPersonalAuthInfoSuccess:(SUserPersonalAuthInfoSuccessBlock)success andFailure:(SUserPersonalAuthInfoFailureBlock)failure {
    [HttpManager getWithUrl:SUserPersonalAuthInfo_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SUserPersonalAuthInfo mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
