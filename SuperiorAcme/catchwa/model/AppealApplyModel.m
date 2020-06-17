//
//  AppealApplyModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/12.
//  Copyright © 2019年 GYM. All rights reserved.
// 申诉页面接口

#import "AppealApplyModel.h"

@implementation AppealApplyModel
- (void)AppealApplyModelSuccess:(AppealApplyModelSuccessBlock)success andFailure:(AppealApplyModelFailureBlock)failure
{
    [HttpManager postSgiftWithUrl:@"Catcher/appealApply" baseurl:SgiftBase_url  andParameters:nil andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [AppealApplyModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"AppealApplyModel"};
        }];
        success(dic[@"code"],dic[@"message"],[AppealApplyModel mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
