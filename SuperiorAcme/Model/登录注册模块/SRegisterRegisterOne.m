//
//  SRegisterRegisterOne.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/23.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SRegisterRegisterOne.h"

@implementation SRegisterRegisterOne

- (void)sRegisterRegisterOneSuccess:(SRegisterRegisterOneSuccessBlock)success andFailure:(SRegisterRegisterOneFailureBlock)failure {
    [HttpManager postWithUrl:SRegisterRegisterOne_Url andParameters:@{@"phone":_phone} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
