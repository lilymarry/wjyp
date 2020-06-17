//
//  SRegisterOtherLogin.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/23.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SRegisterOtherLogin.h"
#define kFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"user.data"]

@implementation SRegisterOtherLogin
static SRegisterOtherLogin * login = nil;

+ (id)shareInstance {
    @synchronized(self) {
        if (login == nil)
            login = [[self alloc] init];
    }
    return login;
}
- (User *)getUserInfo_SuperiorAcme {
    User * user = [NSKeyedUnarchiver unarchiveObjectWithFile:kFile];
    return user;
}
- (void)save:(User *)userInfo {
    [NSKeyedArchiver archiveRootObject:userInfo toFile:kFile];
}
- (void)deleteUserInfo {
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    if ([defaultManager isDeletableFileAtPath:kFile]) {
        [defaultManager removeItemAtPath:kFile error:nil];
    }
}
- (void)sRegisterOtherLoginSuccess:(SRegisterOtherLoginSuccessBlock)success andFailure:(SRegisterOtherLoginFailureBlock)failure {
    [HttpManager postUploadSingleImageWithUrl:SRegisterOtherLogin_Url andImageName:_head_pic andKeyName:@"head_pic" andParameters:@{@"openid":_openid,@"type":_type,@"nickname":_nickname} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        SRegisterOtherLogin *model = [SRegisterOtherLogin mj_objectWithKeyValues:dic];
        [[NSUserDefaults standardUserDefaults] setValue:model.data.invite_code forKey:INVITE_CODE];
        [[NSUserDefaults standardUserDefaults] synchronize];
        success(dic[@"code"],dic[@"message"],model);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
