//
//  SMerchantReportType.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/20.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SMerchantReportType.h"

@implementation SMerchantReportType

- (void)sMerchantReportTypeSuccess:(SMerchantReportTypeSuccessBlock)success andFailure:(SMerchantReportTypeFailureBlock)failure {
    [HttpManager postWithUrl:SMerchantReportType_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SMerchantReportType mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SMerchantReportType"};
        }];
        success(dic[@"code"],dic[@"message"],[SMerchantReportType mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
