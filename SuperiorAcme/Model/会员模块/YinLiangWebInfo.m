//
//  YingLiangWebInfo.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/1/7.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "YinLiangWebInfo.h"

@implementation YinLiangWebInfo
- (void)YinLiangWebInfoSuccess:(YinLiangWebInfoSuccessBlock)success andFailure:(YinLiangWebInfoFailureBlock)failure
{
    [HttpManager postWithUrl:@"User/getUserCoinLogInfoOnDate" andParameters:@{@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [YinLiangWebInfo mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"info":@"YinLiangWebInfo",@"list":@"YinLiangWebInfo"};
        }];
        success(dic[@"code"],dic[@"message"],[YinLiangWebInfo mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
