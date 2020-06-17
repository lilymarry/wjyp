//
//  SUserVerificationPayPwd.m
//  SuperiorAcme
//
//  Created by GYM on 2018/2/9.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SUserVerificationPayPwd.h"

@implementation SUserVerificationPayPwd

- (void)sUserVerificationPayPwdSuccess:(SUserVerificationPayPwdSuccessBlock)success andFailure:(SUserVerificationPayPwdFailureBlock)failure {
    [HttpManager postWithUrl:SUserVerificationPayPwd_Url andParameters:@{@"PayPwd":_PayPwd} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SUserVerificationPayPwd mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
