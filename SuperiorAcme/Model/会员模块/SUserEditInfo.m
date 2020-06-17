//
//  SUserEditInfo.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserEditInfo.h"

@implementation SUserEditInfo

- (void)sUserEditInfoSuccess:(SUserEditInfoSuccessBlock)success andFailure:(SUserEditInfoFailureBlock)failure {
    if (_head_pic != nil) {
        [HttpManager postUploadSingleImageWithUrl:SUserEditInfo_Url andImageName:_head_pic andKeyName:@"head_pic" andParameters:@{@"nickname":_nickname,@"email":_email,@"province_id":_province_id,@"city_id":_city_id,@"area_id":_area_id,@"street_id":_street_id} andSuccess:^(id Json) {
            NSDictionary * dic = (NSDictionary *)Json;
            success(dic[@"code"],dic[@"message"]);
        } andFail:^(NSError *error) {
            failure(error);
        }];
    } else {
        [HttpManager postWithUrl:SUserEditInfo_Url andParameters:@{@"nickname":_nickname,@"email":_email,@"province_id":_province_id,@"city_id":_city_id,@"area_id":_area_id,@"street_id":_street_id} andSuccess:^(id Json) {
            NSDictionary * dic = (NSDictionary *)Json;
            success(dic[@"code"],dic[@"message"]);
        } andFail:^(NSError *error) {
            failure(error);
        }];
    }
}
@end
