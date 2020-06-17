//
//  SUserMessageAnnounceList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserMessageAnnounceList.h"

@implementation SUserMessageAnnounceList

- (void)sUserMessageAnnounceListSuccess:(SUserMessageAnnounceListSuccessBlock)success andFailure:(SUserMessageAnnounceListFailureBlock)failure {
    [HttpManager postWithUrl:SUserMessageAnnounceList_Url andParameters:@{@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SUserMessageAnnounceList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SUserMessageAnnounceList"};
        }];
        success(dic[@"code"],dic[@"message"],[SUserMessageAnnounceList mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
