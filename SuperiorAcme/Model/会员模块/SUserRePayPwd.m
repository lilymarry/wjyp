//
//  SUserRePayPwd.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserRePayPwd.h"

@implementation SUserRePayPwd

- (void)sUserRePayPwdSuccess:(SUserRePayPwdSuccessBlock)success andFailure:(SUserRePayPwdFailureBlock)failure {
    [HttpManager postWithUrl:SUserRePayPwd_Url andParameters:@{@"oldPayPwd":_oldPayPwd,@"newPayPwd":_thisNewPayPwd,@"rePayPwd":_rePayPwd} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
