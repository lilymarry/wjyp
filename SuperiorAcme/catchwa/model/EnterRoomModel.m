//
//  EnterRoomModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/28.
//  Copyright © 2019年 GYM. All rights reserved.
//  进入房间

#import "EnterRoomModel.h"

@implementation EnterRoomModel
- (void)EnterRoomModelSuccess:(EnterRoomModelSuccessBlock)success andFailure:(EnterRoomModelFailureBlock)failure
{
    [HttpManager postSgiftWithUrl:@"Catcher/enterRoom" baseurl:SgiftBase_url  andParameters:@{@"id":_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
      
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
