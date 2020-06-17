//
//  SMerchantReport.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/4.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SMerchantReport.h"

@implementation SMerchantReport

- (void)sMerchantReportSuccess:(SMerchantReportSuccessBlock)success andFailure:(SMerchantReportFailureBlock)failure {
    NSString *urlString = @"";
    if (_isUnderline) {
        urlString = @"Merchant/report";
    }else{
        urlString = SMerchantReport_Url;
    }
    
    if (_report_pic) {
        
        [HttpManager postUploadMultipleImagesWithUrl:urlString andImagesAndNames:_report_pic andParameters:@{@"report_type_id":_report_type_id,@"report_content":_report_content,@"merchant_id":_merchant_id} andSuccess:^(id Json) {
            NSDictionary * dic = (NSDictionary *)Json;
            success(dic[@"code"],dic[@"message"]);
        } andFail:^(NSError *error) {
            failure(error);
        }];
        
    }else{
        [HttpManager postWithUrl:urlString andParameters:@{@"report_type_id":_report_type_id,@"report_content":_report_content,@"merchant_id":_merchant_id,@"report_pic":_report_pic} andSuccess:^(id Json) {
            NSDictionary * dic = (NSDictionary *)Json;
            success(dic[@"code"],dic[@"message"]);
        } andFail:^(NSError *error) {
            failure(error);
        }];
    }
    
}
@end
