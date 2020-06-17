//
//  SAddressSetDefault.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAddressSetDefault.h"

@implementation SAddressSetDefault

- (void)sAddressSetDefaultSuccess:(SAddressSetDefaultSuccessBlock)success andFailure:(SAddressSetDefaultFailureBlock)failure {
    [HttpManager postWithUrl:SAddressSetDefault_Url andParameters:@{@"address_id":_address_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
