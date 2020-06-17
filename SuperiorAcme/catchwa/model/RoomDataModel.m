//
//  RoomData.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/27.
//  Copyright © 2019年 GYM. All rights reserved.
//  房间信息获取

#import "RoomDataModel.h"

@implementation RoomDataModel
- (void)RoomDataModelSuccess:(RoomDataModelSuccessBlock)success andFailure:(RoomDataModelFailureBlock)failure
{
    [HttpManager postSgiftWithUrl:@"/Catcher/catcherDetails" baseurl:SgiftBase_url  andParameters:@{@"id":_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [RoomDataModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"headPic":@"RoomDataModel",@"ads":@"RoomDataModel",@"gDetails":@"RoomDataModel",@"listB":@"RoomDataModel"};
        }];
        success(dic[@"code"],dic[@"message"],[RoomDataModel mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
