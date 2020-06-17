//
//  SRegisterRegister.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/23.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SRegisterRegister.h"

@implementation SRegisterRegister

- (void)sRegisterRegisterSuccess:(SRegisterRegisterSuccessBlock)success andFailure:(SRegisterRegisterFailureBlock)failure {
    [HttpManager postWithUrl:SRegisterRegister_Url andParameters:@{@"phone":_phone,@"password":_password,@"confirmPassword":_confirmPassword,@"invite_code":_invite_code} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
