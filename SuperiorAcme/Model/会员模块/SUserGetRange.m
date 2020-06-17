//
//  SUserGetRange.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserGetRange.h"

@implementation SUserGetRange

- (void)sUserGetRangeSuccess:(SUserGetRangeSuccessBlock)success andFailure:(SUserGetRangeFailureBlock)failure {
    [HttpManager postWithUrl:SUserGetRange_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SUserGetRange mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SUserGetRange"};
        }];
        success(dic[@"code"],dic[@"message"],[SUserGetRange mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
