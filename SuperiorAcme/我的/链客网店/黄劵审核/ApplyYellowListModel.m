//
//  ApplyYellowListModel.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/30.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "ApplyYellowListModel.h"

@implementation ApplyYellowListModel
- (void)ApplyYellowListModelSuccess:(ApplyYellowListModelSuccessBlock)success andFailure:(ApplyYellowListModelFailureBlock)failure {
    NSString *strApi = @"Distribution/vouchersLog";
    [HttpManager postSgiftWithUrl:strApi baseurl:SgiftBase_url  andParameters:@{@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [ApplyYellowListModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"ApplyYellowListModel",@"list":@"ApplyYellowListModel"};
        }];
        success(dic[@"code"],dic[@"message"],[ApplyYellowListModel mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
