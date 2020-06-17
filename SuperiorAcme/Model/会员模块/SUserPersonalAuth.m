//
//  SUserPersonalAuth.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserPersonalAuth.h"

@implementation SUserPersonalAuth

- (void)sUserPersonalAuthSuccess:(SUserPersonalAuthSuccessBlock)success andFailure:(SUserPersonalAuthFailureBlock)failure {
    if (_positive_id_card == nil && _back_id_card == nil) {
        [HttpManager postWithUrl:SUserPersonalAuth_Url andParameters:@{@"real_name":_real_name,@"sex":_sex,@"id_card_num":_id_card_num,@"id_card_start_time":_card_start_time,@"id_card_end_time":_card_end_time,@"auth_province_id":_auth_province_id,@"auth_city_id":_auth_city_id,@"auth_area_id":_auth_area_id,@"auth_street_id":_auth_street_id} andSuccess:^(id Json) {
            NSDictionary * dic = (NSDictionary *)Json;
            success(dic[@"code"],dic[@"message"]);
        } andFail:^(NSError *error) {
            failure(error);
        }];
    } else {
        if (_back_id_card == nil) {
            //身份证背面没上传
            [HttpManager postUploadSingleImageWithUrl:SUserPersonalAuth_Url andImageName:_positive_id_card andKeyName:@"positive_id_card" andParameters:@{@"real_name":_real_name,@"sex":_sex,@"id_card_num":_id_card_num,@"id_card_start_time":_card_start_time,@"id_card_end_time":_card_end_time,@"auth_province_id":_auth_province_id,@"auth_city_id":_auth_city_id,@"auth_area_id":_auth_area_id,@"auth_street_id":_auth_street_id} andSuccess:^(id Json) {
                NSDictionary * dic = (NSDictionary *)Json;
                success(dic[@"code"],dic[@"message"]);
            } andFail:^(NSError *error) {
                failure(error);
            }];
        } else if (_positive_id_card == nil) {
            //身份证正面没上传
            [HttpManager postUploadSingleImageWithUrl:SUserPersonalAuth_Url andImageName:_back_id_card andKeyName:@"back_id_card" andParameters:@{@"real_name":_real_name,@"sex":_sex,@"id_card_num":_id_card_num,@"id_card_start_time":_card_start_time,@"id_card_end_time":_card_end_time,@"auth_province_id":_auth_province_id,@"auth_city_id":_auth_city_id,@"auth_area_id":_auth_area_id,@"auth_street_id":_auth_street_id} andSuccess:^(id Json) {
                NSDictionary * dic = (NSDictionary *)Json;
                success(dic[@"code"],dic[@"message"]);
            } andFail:^(NSError *error) {
                failure(error);
            }];
        } else {
            [HttpManager postUploadMultipleImagesWithUrl:SUserPersonalAuth_Url andImagesAndNames:@{@"positive_id_card":_positive_id_card,@"back_id_card":_back_id_card} andParameters:@{@"real_name":_real_name,@"sex":_sex,@"id_card_num":_id_card_num,@"id_card_start_time":_card_start_time,@"id_card_end_time":_card_end_time,@"auth_province_id":_auth_province_id,@"auth_city_id":_auth_city_id,@"auth_area_id":_auth_area_id,@"auth_street_id":_auth_street_id} andSuccess:^(id Json) {
                NSDictionary * dic = (NSDictionary *)Json;
                success(dic[@"code"],dic[@"message"]);
            } andFail:^(NSError *error) {
                failure(error);
            }];
        }
        
    }
}
@end
