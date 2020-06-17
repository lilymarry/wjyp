//
//  SUserMessageAnnounceInfo.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserMessageAnnounceInfo.h"

@implementation SUserMessageAnnounceInfo

- (void)sUserMessageAnnounceInfoSuccess:(SUserMessageAnnounceInfoSuccessBlock)success andFailure:(SUserMessageAnnounceInfoFailureBlock)failure {
    [HttpManager postWithUrl:SUserMessageAnnounceInfo_Url andParameters:@{@"id":_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SUserMessageAnnounceInfo mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
