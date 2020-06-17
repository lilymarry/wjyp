//
//  PeopleInRoomModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/28.
//  Copyright © 2019年 GYM. All rights reserved.
//  房间用户列表

#import "PeopleInRoomModel.h"

@implementation PeopleInRoomModel
- (void)PeopleInRoomModelSuccess:(PeopleInRoomModelSuccessBlock)success andFailure:(PeopleInRoomModelFailureBlock)failure
{
    [HttpManager postSgiftWithUrl:@"Catcher/roomPeople" baseurl:SgiftBase_url  andParameters:@{@"id":_cid} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [PeopleInRoomModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"RoomPeople":@"PeopleInRoomModel"};
        }];
        success(dic[@"code"],dic[@"message"],[PeopleInRoomModel mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
