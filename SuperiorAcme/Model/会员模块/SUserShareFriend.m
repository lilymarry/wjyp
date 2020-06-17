//
//  SUserShareFriend.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/21.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserShareFriend.h"

@implementation SUserShareFriend

- (void)sUserShareFriendSuccess:(SUserShareFriendSuccessBlock)success andFailure:(SUserShareFriendFailureBlock)failure {
    [HttpManager postWithUrl:SUserShareFriend_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SUserShareFriend mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
