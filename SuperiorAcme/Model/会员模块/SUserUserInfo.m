//
//  SUserUserInfo.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserUserInfo.h"

@implementation SUserUserInfo

- (void)sUserUserInfoSuccess:(SUserUserInfoSuccessBlock)success andFailure:(SUserUserInfoFailureBlock)failure {
    [HttpManager postWithUrl:SUserUserInfo_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SUserUserInfo mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
