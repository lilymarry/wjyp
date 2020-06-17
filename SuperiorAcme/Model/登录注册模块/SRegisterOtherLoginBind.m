//
//  SRegisterOtherLoginBind.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/23.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SRegisterOtherLoginBind.h"

@implementation SRegisterOtherLoginBind

- (void)sRegisterOtherLoginBindSuccess:(SRegisterOtherLoginBindSuccessBlock)success andFailure:(SRegisterOtherLoginBindFailureBlock)failure {
    [HttpManager postWithUrl:SRegisterOtherLoginBind_Url andParameters:@{@"bind_id":_bind_id,@"phone":_phone,@"verify":_verify,@"invite_code":_invite_code} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SRegisterOtherLoginBind mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
