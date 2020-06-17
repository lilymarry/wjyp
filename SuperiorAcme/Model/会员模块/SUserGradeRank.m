//
//  SUserGradeRank.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/5.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserGradeRank.h"

@implementation SUserGradeRank

- (void)sUserGradeRankSuccess:(SUserGradeRankSuccessBlock)success andFailure:(SUserGradeRankFailureBlock)failure {
    [HttpManager postWithUrl:SUserGradeRank_Url andParameters:@{@"city_name":_city_name,@"type":_type,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SUserGradeRank mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"rank_list":@"SUserGradeRank"};
        }];
        success(dic[@"code"],dic[@"message"],[SUserGradeRank mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
