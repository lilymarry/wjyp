//
//  SAddressGetOneAddress.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAddressGetOneAddress.h"

@implementation SAddressGetOneAddress

- (void)sAddressGetOneAddressSuccess:(SAddressGetOneAddressSuccessBlock)success andFailure:(SAddressGetOneAddressFailureBlock)failure {
    [HttpManager postWithUrl:SAddressGetOneAddress_Url andParameters:@{@"address_id":_address_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SAddressGetOneAddress mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
