//
//  SMerchantMerIndex.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/4.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SMerchantMerIndex.h"

@implementation SMerchantMerIndex

- (void)sMerchantMerIndexSuccess:(SMerchantMerIndexSuccessBlock)success andFailure:(SMerchantMerIndexFailureBlock)failure {
    [HttpManager postWithUrl:SMerchantMerIndex_Url andParameters:@{@"merchant_id":_merchant_id,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SMerchantMerIndex mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"ticket_list":@"SMerchantMerIndex",@"ads_list":@"SMerchantMerIndex"};
        }];
        success(dic[@"code"],dic[@"message"],[SMerchantMerIndex mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
