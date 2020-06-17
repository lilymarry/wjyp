//
//  ChangeRoomStatus.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/28.
//  Copyright © 2019年 GYM. All rights reserved.
//  关闭开始游戏弹框修改房间状态 退出房间

#import "ChangeRoomStatus.h"

@implementation ChangeRoomStatus
- (void)ChangeRoomStatusSuccess:(ChangeRoomStatusSuccessBlock)success andFailure:(ChangeRoomStatusFailureBlock)failure
{
    NSString *url;
    NSDictionary *para;
    //更改房间状态
    if ([_type isEqualToString:@"1"]) {
        url=@"Catcher/roomStatus";
        para= @{@"cid":_cid};
    }
    //退出房间
    if ([_type isEqualToString:@"2"]) {
        url=@"Catcher/outRoom";
        para= @{@"id":_cid};
    }
    //新人奖励
    if ([_type isEqualToString:@"3"]) {
        url=@"Catcher/newAward";
        para= nil;
    }
  [HttpManager postSgiftWithUrl:url baseurl:SgiftBase_url  andParameters:para andSuccess:^(id Json) {
    NSDictionary * dic = (NSDictionary *)Json;
    
    success(dic[@"code"],dic[@"message"]);
} andFail:^(NSError *error) {
    failure(error);
}];
}
@end
