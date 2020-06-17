//
//  SRegisterCheckVerify.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/23.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SRegisterCheckVerify.h"

@implementation SRegisterCheckVerify

- (void)sRegisterCheckVerifySuccess:(SRegisterCheckVerifySuccessBlock)success andFailure:(SRegisterCheckVerifyFailureBlock)failure {
    [HttpManager postWithUrl:SRegisterCheckVerify_Url andParameters:@{@"phone":_phone,@"type":_type,@"verify":_verify} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
