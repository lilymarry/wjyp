//
//  SCompanyDevelopCompanyList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCompanyDevelopCompanyList.h"

@implementation SCompanyDevelopCompanyList

- (void)sCompanyDevelopCompanyListSuccess:(SCompanyDevelopCompanyListSuccessBlock)success andFailure:(SCompanyDevelopCompanyListFailureBlock)failure {
    [HttpManager postWithUrl:SCompanyDevelopCompanyList_Url andParameters:@{@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SCompanyDevelopCompanyList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"ads":@"SCompanyDevelopCompanyList",@"mer_list":@"SCompanyDevelopCompanyList"};
        }];
        success(dic[@"code"],dic[@"message"],[SCompanyDevelopCompanyList mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
