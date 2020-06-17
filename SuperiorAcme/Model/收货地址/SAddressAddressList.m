//
//  SAddressAddressList.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAddressAddressList.h"

@implementation SAddressAddressList

- (void)sAddressAddressListSuccess:(SAddressAddressListSuccessBlock)success andFailure:(SAddressAddressListFailureBlock)failure {
    [HttpManager postWithUrl:SAddressAddressList_Url andParameters:@{@"p":_p} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SAddressAddressList mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"common_address":@"SAddressAddressList"};
        }];
        success(dic[@"code"],dic[@"message"],[SAddressAddressList mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
