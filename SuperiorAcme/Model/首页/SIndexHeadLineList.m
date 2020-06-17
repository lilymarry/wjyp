//
//  SIndexHeadLineList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/10/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SIndexHeadLineList.h"

@implementation SIndexHeadLineList

- (void)sIndexHeadLineListSuccess:(SIndexHeadLineListSuccessBlock)success andFailure:(SIndexHeadLineListFailureBlock)failure {
    [HttpManager postWithUrl:SIndexHeadLineList_Url andParameters:@{@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SIndexHeadLineList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SIndexHeadLineList"};
        }];
        success(dic[@"code"],dic[@"message"],[SIndexHeadLineList mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
