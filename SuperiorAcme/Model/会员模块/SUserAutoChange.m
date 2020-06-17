//
//  SUserAutoChange.m
//  SuperiorAcme
//
//  Created by GYM on 2018/4/3.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SUserAutoChange.h"

@implementation SUserAutoChange

- (void)sUserAutoChangeSuccess:(SUserAutoChangeSuccessBlock)success andFailure:(SUserAutoChangeFailureBlock)failure {
    [HttpManager postWithUrl:SUserAutoChange_Url andParameters:@{@"integral":_integral} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SUserAutoChange mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
