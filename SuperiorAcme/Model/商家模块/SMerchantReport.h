//
//  SMerchantReport.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/4.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SMerchantReportSuccessBlock) (NSString * code, NSString * message);
typedef void(^SMerchantReportFailureBlock) (NSError * error);

@interface SMerchantReport : NSObject
@property (nonatomic, copy) NSString * report_type_id;//举报类型
@property (nonatomic, copy) NSString * report_content;//举报理由
@property (nonatomic, copy) NSString * merchant_id;   //商家id
@property (nonatomic, strong) NSDictionary *report_pic;     //上传凭证
@property (nonatomic, assign) BOOL isUnderline;   //是不是线下  默认否NO


- (void)sMerchantReportSuccess:(SMerchantReportSuccessBlock)success andFailure:(SMerchantReportFailureBlock)failure;
@end
