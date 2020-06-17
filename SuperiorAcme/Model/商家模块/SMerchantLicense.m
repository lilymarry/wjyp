//
//  SMerchantLicense.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/4.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SMerchantLicense.h"

@implementation SMerchantLicense

- (void)sMerchantLicenseSuccess:(SMerchantLicenseSuccessBlock)success andFailure:(SMerchantLicenseFailureBlock)failure {
    [HttpManager postWithUrl:SMerchantLicense_Url andParameters:@{@"merchant_id":_merchant_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SMerchantLicense mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SMerchantLicense"};
        }];
        success(dic[@"code"],dic[@"message"],[SMerchantLicense mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
