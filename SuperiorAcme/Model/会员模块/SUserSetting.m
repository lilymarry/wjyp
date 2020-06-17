//
//  SUserSetting.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserSetting.h"

@implementation SUserSetting

- (void)sUserSettingSuccess:(SUserSettingSuccessBlock)success andFailure:(SUserSettingFailureBlock)failure {
    [HttpManager postWithUrl:SUserSetting_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SUserSetting mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
