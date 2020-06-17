//
//  SAddressEditAddress.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAddressEditAddress.h"

@implementation SAddressEditAddress

- (void)sAddressEditAddressSuccess:(SAddressEditAddressSuccessBlock)success andFailure:(SAddressEditAddressFailureBlock)failure {
    [HttpManager postWithUrl:SAddressEditAddress_Url andParameters:@{@"address_id":_address_id,@"receiver":_receiver,@"phone":_phone,@"province":_province,@"city":_city,@"area":_area,@"street":_street,@"province_id":_province_id,@"city_id":_city_id,@"area_id":_area_id,@"street_id":_street_id,@"address":_address,@"lng":_lng != nil ? _lng : @"",@"lat":_lat != nil ? _lat : @""} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
