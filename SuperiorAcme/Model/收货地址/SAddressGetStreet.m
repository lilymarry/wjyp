//
//  SAddressGetStreet.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAddressGetStreet.h"

@implementation SAddressGetStreet

- (void)sAddressGetStreetSuccess:(SAddressGetStreetSuccessBlock)success andFailure:(SAddressGetStreetFailureBlock)failure {
    [HttpManager postWithUrl:SAddressGetStreet_Url andParameters:@{@"area_id":_area_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SAddressGetStreet mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"SAddressGetStreet"};
        }];
        success(dic[@"code"],dic[@"message"],[SAddressGetStreet mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
