//
//  SUserChangePassword.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserChangePassword.h"

@implementation SUserChangePassword

- (void)sUserChangePasswordSuccess:(SUserChangePasswordSuccessBlock)success andFailure:(SUserChangePasswordFailureBlock)failure {
    [HttpManager postWithUrl:SUserChangePassword_Url andParameters:@{@"oldPassword":_oldPassword,@"newPassword":_thisNewPassword,@"rePassword":_rePassword} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
