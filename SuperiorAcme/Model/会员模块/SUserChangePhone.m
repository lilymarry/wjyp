//
//  SUserChangePhone.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserChangePhone.h"

@implementation SUserChangePhone

- (void)sUserChangePhoneSuccess:(SUserChangePhoneSuccessBlock)success andFailure:(SUserChangePhoneFailureBlock)failure {
    [HttpManager postWithUrl:SUserChangePhone_Url andParameters:@{@"newPhone":_thisNewPhone,@"verify":_verify} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
