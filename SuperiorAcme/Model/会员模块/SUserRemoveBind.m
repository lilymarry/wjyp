//
//  SUserRemoveBind.m
//  SuperiorAcme
//
//  Created by GYM on 2017/10/18.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserRemoveBind.h"

@implementation SUserRemoveBind

- (void)sUserRemoveBindSuccess:(SUserRemoveBindSuccessBlock)success andFailure:(SUserRemoveBindFailureBlock)failure {
    [HttpManager postWithUrl:SUserRemoveBind_Url andParameters:@{@"type":_type} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
