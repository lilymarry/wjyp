//
//  SUserGetSignCode.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserGetSignCode.h"

@implementation SUserGetSignCode

- (void)sUserGetSignCodeSuccess:(SUserGetSignCodeSuccessBlock)success andFailure:(SUserGetSignCodeFailureBlock)failure {
    [HttpManager postWithUrl:SUserGetSignCode_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SUserGetSignCode mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
