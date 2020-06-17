//
//  SRecommendingAddBusiness.m
//  SuperiorAcme
//
//  Created by GYM on 2018/2/2.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SRecommendingAddBusiness.h"

@implementation SRecommendingAddBusiness

- (void)sRecommendingAddBusinessSuccess:(SRecommendingAddBusinessSuccessBlock)success andFailure:(SRecommendingAddBusinessFailureBlock)failure {
    
    [HttpManager postUploadMultipleImagesWithUrl:SRecommendingAddBusiness_Url andImagesAndNames:_pic andParameters:@{@"mechant_name":_mechant_name,@"user_name":_user_name,@"user_position":_user_position,@"user_phone":_user_phone,@"city":_city,@"street":_street,@"desc":_desc,@"type":_type,@"rec_type_id":_rec_type_id} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
    
}
@end
