//
//  SUserSetPayPwd.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserSetPayPwd.h"

@implementation SUserSetPayPwd

- (void)sUserSetPayPwdSuccess:(SUserSetPayPwdSuccessBlock)success andFailure:(SUserSetPayPwdFailureBlock)failure {
    [HttpManager postWithUrl:SUserSetPayPwd_Url andParameters:@{@"newPayPwd":_thisNewPayPwd,@"rePayPwd":_rePayPwd} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
