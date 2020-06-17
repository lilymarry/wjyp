//
//  SIndexHeadInfo.m
//  SuperiorAcme
//
//  Created by GYM on 2017/10/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SIndexHeadInfo.h"

@implementation SIndexHeadInfo

- (void)sIndexHeadInfoSuccess:(SIndexHeadInfoSuccessBlock)success andFailure:(SIndexHeadInfoFailureBlock)failure {
    [HttpManager postWithUrl:SIndexHeadInfo_Url andParameters:@{@"headlines_id":_headlines_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SIndexHeadInfo mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
