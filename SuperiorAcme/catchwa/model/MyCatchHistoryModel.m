//
//  CatchHistoryModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/27.
//  Copyright © 2019年 GYM. All rights reserved.
//根据user_id及类型获取抓娃娃记录日志信息

#import "MyCatchHistoryModel.h"

@implementation MyCatchHistoryModel
- (void)MyCatchHistoryModelSuccess:(MyCatchHistoryModelSuccessBlock)success andFailure:(MyCatchHistoryModelFailureBlock)failure
{
    [HttpManager postSgiftWithUrl:@"Catcher/getCatchersLogs" baseurl:SgiftBase_url  andParameters:@{@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [MyCatchHistoryModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"MyCatchHistoryModel"};
        }];
        success(dic[@"code"],dic[@"message"],[MyCatchHistoryModel mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
