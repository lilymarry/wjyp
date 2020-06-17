//
//  SCompanyDevelopCompanyInfo.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCompanyDevelopCompanyInfo.h"

@implementation SCompanyDevelopCompanyInfo

- (void)sCompanyDevelopCompanyInfoSuccess:(SCompanyDevelopCompanyInfoSuccessBlock)success andFailure:(SCompanyDevelopCompanyInfoFailureBlock)failure {
    [HttpManager postWithUrl:SCompanyDevelopCompanyInfo_Url andParameters:@{@"company_id":_company_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SCompanyDevelopCompanyInfo mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
