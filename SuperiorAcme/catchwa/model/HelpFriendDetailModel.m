//
//  HelpFriendDetailModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/15.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "HelpFriendDetailModel.h"

@implementation HelpFriendDetailModel
- (void)HelpFriendDetailModelSuccess:(HelpFriendDetailModelSuccessBlock)success andFailure:(HelpFriendDetailModelFailureBlock)failure

{
    [HttpManager postSgiftWithUrl:@"FriendBoost/RouletteFriendApp" baseurl:SgiftBase_url  andParameters:nil andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[HelpFriendDetailModel mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
