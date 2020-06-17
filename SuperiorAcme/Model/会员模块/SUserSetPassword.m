//
//  SUserSetPassword.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserSetPassword.h"

@implementation SUserSetPassword

- (void)sUserSetPasswordSuccess:(SUserSetPasswordSuccessBlock)success andFailure:(SUserSetPasswordFailureBlock)failure {
    [HttpManager postWithUrl:SUserSetPassword_Url andParameters:@{@"newPassword":_thisNewPassword,@"rePassword":_rePassword} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
