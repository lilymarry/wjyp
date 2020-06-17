//
//  SUserCompAuth.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserCompAuth.h"

@implementation SUserCompAuth

- (void)sUserCompAuthSuccess:(SUserCompAuthSuccessBlock)success andFailure:(SUserCompAuthFailureBlock)failure {
    if (_comp_business_license == nil) {
        [HttpManager postWithUrl:SUserCompAuth_Url andParameters:@{@"com_name":_com_name,@"comp_reg_num":_comp_reg_num,@"comp_start_time":_comp_start_time,@"comp_end_time":_comp_end_time,@"comp_province_id":_comp_province_id,@"comp_city_id":_comp_city_id,@"comp_area_id":_comp_area_id,@"comp_street_id":_comp_street_id} andSuccess:^(id Json) {
            NSDictionary * dic = (NSDictionary *)Json;
            success(dic[@"code"],dic[@"message"]);
        } andFail:^(NSError *error) {
            failure(error);
        }];
    } else {
        [HttpManager postUploadSingleImageWithUrl:SUserCompAuth_Url andImageName:_comp_business_license andKeyName:@"comp_business_license" andParameters:@{@"com_name":_com_name,@"comp_reg_num":_comp_reg_num,@"comp_start_time":_comp_start_time,@"comp_end_time":_comp_end_time,@"comp_province_id":_comp_province_id,@"comp_city_id":_comp_city_id,@"comp_area_id":_comp_area_id,@"comp_street_id":_comp_street_id} andSuccess:^(id Json) {
            NSDictionary * dic = (NSDictionary *)Json;
            success(dic[@"code"],dic[@"message"]);
        } andFail:^(NSError *error) {
            failure(error);
        }];
    }
}
@end
