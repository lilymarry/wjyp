//
//  SUserMessageOrderMsgList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserMessageOrderMsgList.h"

@implementation SUserMessageOrderMsgList

- (void)sUserMessageOrderMsgListSuccess:(SUserMessageOrderMsgListSuccessBlock)success andFailure:(SUserMessageOrderMsgListFailureBlock)failure {
    [HttpManager postWithUrl:SUserMessageOrderMsgList_Url andParameters:@{@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SUserMessageOrderMsgList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SUserMessageOrderMsgList"};
        }];
        success(dic[@"code"],dic[@"message"],[SUserMessageOrderMsgList mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
