//
//  SAcademyAcademyInfo.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAcademyAcademyInfo.h"

@implementation SAcademyAcademyInfo

- (void)sAcademyAcademyInfoSuccess:(SAcademyAcademyInfoSuccessBlock)success andFailure:(SAcademyAcademyInfoFailureBlock)failure {
    [HttpManager postWithUrl:SAcademyAcademyInfo_Url andParameters:@{@"academy_id":_academy_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SAcademyAcademyInfo mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
