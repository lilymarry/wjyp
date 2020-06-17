//
//  SUserMessageMsgList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserMessageMsgList.h"

@implementation SUserMessageMsgList

- (void)sUserMessageMsgListSuccess:(SUserMessageMsgListSuccessBlock)success andFailure:(SUserMessageMsgListFailureBlock)failure {
    [HttpManager postWithUrl:SUserMessageMsgList_Url andParameters:@{@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SUserMessageMsgList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SUserMessageMsgList"};
        }];
        success(dic[@"code"],dic[@"message"],[SUserMessageMsgList mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
