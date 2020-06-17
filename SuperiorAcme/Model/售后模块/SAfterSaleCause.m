//
//  SAfterSaleCause.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAfterSaleCause.h"

@implementation SAfterSaleCause

- (void)sAfterSaleCauseSuccess:(SAfterSaleCauseSuccessBlock)success andFailure:(SAfterSaleCauseFailureBlock)failure {
    [HttpManager postWithUrl:SAfterSaleCause_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SAfterSaleCause mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SAfterSaleCause"};
        }];
        success(dic[@"code"],dic[@"message"],[SAfterSaleCause mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
