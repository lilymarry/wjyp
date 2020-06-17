//
//  SMerchantMerInfo.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/4.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SMerchantMerInfo.h"

@implementation SMerchantMerInfo

- (void)sMerchantMerInfoSuccess:(SMerchantMerInfoSuccessBlock)success andFailure:(SMerchantMerInfoFailureBlock)failure {
    [HttpManager postWithUrl:SMerchantMerInfo_Url andParameters:@{@"merchant_id":_merchant_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SMerchantMerInfo mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
