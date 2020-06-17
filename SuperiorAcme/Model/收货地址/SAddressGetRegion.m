//
//  SAddressGetRegion.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAddressGetRegion.h"

@implementation SAddressGetRegion

- (void)sAddressGetRegionSuccess:(SAddressGetRegionSuccessBlock)success andFailure:(SAddressGetRegionFailureBlock)failure {
    [HttpManager postWithUrl:SAddressGetRegion_Url andParameters:@{@"region_id":_region_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        [SAddressGetRegion mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"province_list":@"SAddressGetRegion",@"city_list":@"SAddressGetRegion",@"area_list":@"SAddressGetRegion",@"hot_list":@"SAddressGetRegion",@"city":@"SAddressGetRegion"};
        }];
        success(dic[@"code"],dic[@"message"],[SAddressGetRegion mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
