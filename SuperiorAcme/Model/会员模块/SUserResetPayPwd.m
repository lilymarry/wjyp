//
//  SUserResetPayPwd.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/8.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserResetPayPwd.h"

@implementation SUserResetPayPwd

- (void)sUserResetPayPwdSuccess:(SUserResetPayPwdSuccessBlock)success andFailure:(SUserResetPayPwdFailureBlock)failure {
    [HttpManager postWithUrl:SUserResetPayPwd_Url andParameters:@{@"phone":_phone,@"verify":_verify,@"newPayPwd":_thisNewPayPwd,@"rePayPwd":_rePayPwd} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
