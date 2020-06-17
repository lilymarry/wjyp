//
//  SUserReferList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserReferList.h"

@implementation SUserReferList

- (void)sUserReferListSuccess:(SUserReferListSuccessBlock)success andFailure:(SUserReferListFailureBlock)failure {
    [HttpManager postWithUrl:SUserReferList_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SUserReferList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SUserReferList"};
        }];
        success(dic[@"code"],dic[@"message"],[SUserReferList mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
