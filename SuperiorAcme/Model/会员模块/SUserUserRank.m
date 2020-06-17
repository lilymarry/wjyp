//
//  SUserUserRank.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserUserRank.h"

@implementation SUserUserRank

- (void)sUserUserRankSuccess:(SUserUserRankSuccessBlock)success andFailure:(SUserUserRankFailureBlock)failure {
    [HttpManager postWithUrl:SUserUserRank_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SUserUserRank mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"rank_list":@"SUserUserRank"};
        }];
        success(dic[@"code"],dic[@"message"],[SUserUserRank mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
