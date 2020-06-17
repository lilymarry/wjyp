//
//  SAcademyAcademyIndex.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAcademyAcademyIndex.h"

@implementation SAcademyAcademyIndex

- (void)sAcademyAcademyIndexSuccess:(SAcademyAcademyIndexSuccessBlock)success andFailure:(SAcademyAcademyIndexFailureBlock)failure {
    [HttpManager postWithUrl:SAcademyAcademyIndex_Url andParameters:@{@"ac_type_id":_ac_type_id,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SAcademyAcademyIndex mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"ac_type_list":@"SAcademyAcademyIndex",@"bannerList":@"SAcademyAcademyIndex",@"academy_list":@"SAcademyAcademyIndex"};
        }];
        success(dic[@"code"],dic[@"message"],[SAcademyAcademyIndex mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
