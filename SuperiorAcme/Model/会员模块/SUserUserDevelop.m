//
//  SUserUserDevelop.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserUserDevelop.h"

@implementation SUserUserDevelop

- (void)sUserUserDevelopSuccess:(SUserUserDevelopSuccessBlock)success andFailure:(SUserUserDevelopFailureBlock)failure {
    [HttpManager postWithUrl:SUserUserDevelop_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SUserUserDevelop mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"level_list":@"SUserUserDevelop"};
        }];
        success(dic[@"code"],dic[@"message"],[SUserUserDevelop mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
