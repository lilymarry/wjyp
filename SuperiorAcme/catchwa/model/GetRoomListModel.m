//
//  getRoomListModel.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/30.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//  获取房间列表

#import "GetRoomListModel.h"

@implementation GetRoomListModel
- (void)getRoomListModelSuccess:(getRoomListModelSuccessBlock)success andFailure:(getRoomListModelFailureBlock)failure
{
    
    [HttpManager postSgiftWithUrl:@"Catcher/getRoomList" baseurl:SgiftBase_url  andParameters:@{@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [GetRoomListModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"list":@"GetRoomListModel",@"victory":@"GetRoomListModel",@"banner":@"GetRoomListModel",@"sx":@"GetRoomListModel",@"sign_news":@"GetRoomListModel"};
        }];
        success(dic[@"code"],dic[@"message"],[GetRoomListModel mj_objectWithKeyValues:dic],dic[@"data"][@"new"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
