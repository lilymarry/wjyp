//
//  CatchHistoryModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/27.
//  Copyright © 2019年 GYM. All rights reserved.
//首页抓取记录列表

#import "UserCatchHistoryModel.h"

@implementation UserCatchHistoryModel
- (void)UserCatchHistoryModelSuccess:(UserCatchHistoryModelSuccessBlock)success andFailure:(UserCatchHistoryModelFailureBlock)failure
{
    [HttpManager postSgiftWithUrl:@"Catcher/userCatcher" baseurl:SgiftBase_url  andParameters:nil andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [UserCatchHistoryModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"UserCatchHistoryModel"};
        }];
        success(dic[@"code"],dic[@"message"],[UserCatchHistoryModel mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
