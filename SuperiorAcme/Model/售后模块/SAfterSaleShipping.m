//
//  SAfterSaleShipping.m
//  SuperiorAcme
//
//  Created by GYM on 2017/12/12.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAfterSaleShipping.h"

@implementation SAfterSaleShipping

- (void)sAfterSaleShippingSuccess:(SAfterSaleShippingSuccessBlock)success andFailure:(SAfterSaleShippingFailureBlock)failure {
    [HttpManager postWithUrl:SAfterSaleShipping_Url andParameters:@{} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SAfterSaleShipping mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SAfterSaleShipping"};
        }];
        success(dic[@"code"],dic[@"message"],[SAfterSaleShipping mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}

- (void)expressNamesFromOrderSN:(NSString *)orderSN success:(expressOrderSNSuccessBlock)success  failure:(expressOrderSNFailureBlock)failure {
    [HttpManager postWithUrl:SAfterSaleGetCompanyName_Url andParameters:@{@"invoice":orderSN == nil ? @"" : orderSN} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        if (success) {
            success(dic);
        }
    } andFail:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
