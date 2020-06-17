//
//  SUserMerchantRefer.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SUserMerchantRefer.h"

@implementation SUserMerchantRefer

- (void)sUserMerchantReferSuccess:(SUserMerchantReferSuccessBlock)success andFailure:(SUserMerchantReferFailureBlock)failure {
    [HttpManager postUploadMultipleImagesWithUrl:SUserMerchantRefer_Url andImagesAndNames:_pic_dic andParameters:@{@"name":_name,@"range_id":_range_id,@"link_man":_link_man,@"link_phone":_link_phone,@"job":_job,@"tmail_url":_tmail_url,@"jd_url":_jd_url,@"other_url":_other_url,@"product_desc":_product_desc} andSuccess:^(id Json) {
        NSDictionary * dic = (NSDictionary *)Json;
        success(dic[@"code"],dic[@"message"],[SUserMerchantRefer mj_objectWithKeyValues:dic]);
    } andFail:^(NSError *error) {
        failure(error);
    }];
}
@end
