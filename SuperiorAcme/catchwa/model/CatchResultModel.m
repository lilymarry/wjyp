//
//  CatchResultModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/26.
//  Copyright © 2019年 GYM. All rights reserved.
// 抓娃娃结束后信息回调

#import "CatchResultModel.h"

@implementation CatchResultModel
- (void)CatchResultModelSuccess:(CatchResultModelSuccessBlock)success andFailure:(CatchResultModelFailureBlock)failure
{
    [HttpManager postSgiftWithUrl:@"Catcher/postCatcherData" baseurl:SgiftBase_url  andParameters:@{@"logId":_logId,@"mode":_mode} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
