//
//  SUserUserCenter.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserUserCenter.h"

@implementation SUserUserCenter

- (void)sUserUserCenterSuccess:(SUserUserCenterSuccessBlock)success andFailure:(SUserUserCenterFailureBlock)failure {
    [HttpManager postWithUrl:SUserUserCenter_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SUserUserCenter mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
