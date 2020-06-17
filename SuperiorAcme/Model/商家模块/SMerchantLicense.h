//
//  SMerchantLicense.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/4.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SMerchantLicenseSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SMerchantLicenseFailureBlock) (NSError * error);

@interface SMerchantLicense : NSObject
@property (nonatomic, copy) NSString * merchant_id;//商家id

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * name;//": "营业执照",//证件名称
@property (nonatomic, copy) NSString * status;//": 1  //1已认证 0未认证

- (void)sMerchantLicenseSuccess:(SMerchantLicenseSuccessBlock)success andFailure:(SMerchantLicenseFailureBlock)failure;
@end
