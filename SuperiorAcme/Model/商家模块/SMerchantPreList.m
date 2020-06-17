//
//  SMerchantPreList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/4.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SMerchantPreList.h"

@implementation SMerchantPreList

- (void)sMerchantPreListSuccess:(SMerchantPreListSuccessBlock)success andFailure:(SMerchantPreListFailureBlock)failure {
    [HttpManager postWithUrl:SMerchantPreList_Url andParameters:@{@"merchant_id":_merchant_id,@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SMerchantPreList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"ticket_list":@"SMerchantPreList",@"goods_list":@"SMerchantPreList"};
        }];
        success(dic[@"code"],dic[@"message"],[SMerchantPreList mj_objectWithKeyValues:dic],dic[@"nums"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
