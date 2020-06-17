//
//  SRegisterLogin.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/23.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SRegisterLogin.h"
#import <JPUSHService.h>
#define kFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"user.data"]

@implementation SRegisterLogin
static SRegisterLogin * login = nil;
static NSInteger seq = 0;
- (NSInteger)seq {
    return ++ seq;
}
+ (instancetype)shareInstance {
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
    
    NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.www.wujiemall.com"];
    [userDefaults setValue:userInfo.token forKey:@"token"];
}
- (void)deleteUserInfo {
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    if ([defaultManager isDeletableFileAtPath:kFile]) {
        [defaultManager removeItemAtPath:kFile error:nil];
    }
//     NSString *registrationID = [[NSUserDefaults standardUserDefaults] valueForKey:@"SA_RegistrationID"];
//    if (registrationID.length>0) {
//         NSMutableSet * tags = [[NSMutableSet alloc] init];
//         [tags addObjectsFromArray:[NSArray arrayWithObjects:registrationID, nil]];
//        [JPUSHService deleteTags:tags completion:^(NSInteger iResCode, NSSet *iTags, NSInteger seq) {
//
//        } seq:[self seq]];
//    }

    [[NSUserDefaults standardUserDefaults] removeObjectForKey:INVITE_CODE];
  //  [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SA_RegistrationID"];
   NSUserDefaults *userDefaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.www.wujiemall.com"];
    [userDefaults removeObjectForKey:@"token"];

    
}

+(NSString *)shareInviteCode{
   NSString *invite_code = [[NSUserDefaults standardUserDefaults] valueForKey:INVITE_CODE];
    if (!SWNOTEmptyStr(invite_code)) {
        invite_code = @"";
    }
    return invite_code;
}

+(NSString *)shareAppendInviteCode{
    NSString *invite_code = [[NSUserDefaults standardUserDefaults] valueForKey:INVITE_CODE];
    if (!SWNOTEmptyStr(invite_code)) {
        invite_code = @"";
    }else{
        invite_code = [NSString stringWithFormat:@"/invite_code/%@",invite_code];
        ///invite_code/%@
    }
    return invite_code;
}


- (void)sRegisterLoginSuccess:(SRegisterLoginSuccessBlock)success andFailure:(SRegisterLoginFailureBlock)failure {
    [HttpManager postWithUrl:SRegisterLogin_Url andParameters:@{@"phone":_phone,@"password":_password} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        SRegisterLogin *model = [SRegisterLogin mj_objectWithKeyValues:dic];
        [[NSUserDefaults standardUserDefaults] setValue:model.data.invite_code forKey:INVITE_CODE];
        [[NSUserDefaults standardUserDefaults] synchronize];
        success(dic[@"code"],dic[@"message"],model);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
