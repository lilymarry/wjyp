//
//  SAddressAddAddress.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/9.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAddressAddAddress.h"

@implementation SAddressAddAddress

- (void)sAddressAddAddressSuccess:(SAddressAddAddressSuccessBlock)success andFailure:(SAddressAddAddressFailureBlock)failure {
    [HttpManager postWithUrl:SAddressAddAddress_Url andParameters:@{@"receiver":_receiver,@"phone":_phone,@"province":_province,@"city":_city,@"area":_area,@"street":_street,@"province_id":_province_id,@"city_id":_city_id,@"area_id":_area_id,@"street_id":_street_id,@"address":_address,@"lng":_lng,@"lat":_lat} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
