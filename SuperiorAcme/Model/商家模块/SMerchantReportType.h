//
//  SMerchantReportType.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/20.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SMerchantReportTypeSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SMerchantReportTypeFailureBlock) (NSError * error);

@interface SMerchantReportType : NSObject

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * report_type_id;//"id",
@property (nonatomic, copy) NSString * title;//"标题"

- (void)sMerchantReportTypeSuccess:(SMerchantReportTypeSuccessBlock)success andFailure:(SMerchantReportTypeFailureBlock)failure;
@end
