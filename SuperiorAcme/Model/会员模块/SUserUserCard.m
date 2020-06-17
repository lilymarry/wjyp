//
//  SUserUserCard.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/30.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SUserUserCard.h"

@implementation SUserUserCard

- (void)sUserUserCardSuccess:(SUserUserCardSuccessBlock)success andFailure:(SUserUserCardFailureBlock)failure {
    [HttpManager postWithUrl:SUserUserCard_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SUserUserCard mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"list":@"SUserUserCard",@"abs_url":@"SUserUserCard",@"advertisement":@"SUserUserCard"};
        }];
        success(dic[@"code"],dic[@"message"],[SUserUserCard mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
