//
//  SAddressDelAddress.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAddressDelAddress.h"

@implementation SAddressDelAddress

- (void)sAddressDelAddressSuccess:(SAddressDelAddressSuccessBlock)success andFailure:(SAddressDelAddressFailureBlock)failure {
    [HttpManager postWithUrl:SAddressDelAddress_Url andParameters:@{@"address_id":_address_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
