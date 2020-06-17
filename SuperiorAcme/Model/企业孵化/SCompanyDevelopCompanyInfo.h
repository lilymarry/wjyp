//
//  SCompanyDevelopCompanyInfo.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/11.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SCompanyDevelopCompanyInfoSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SCompanyDevelopCompanyInfoFailureBlock) (NSError * error);

@interface SCompanyDevelopCompanyInfo : NSObject
@property (nonatomic, copy) NSString * company_id;//企业id

@property (nonatomic, strong) SCompanyDevelopCompanyInfo * data;
@property (nonatomic, copy) NSString * content;//"简介内容"//HTML格式

- (void)sCompanyDevelopCompanyInfoSuccess:(SCompanyDevelopCompanyInfoSuccessBlock)success andFailure:(SCompanyDevelopCompanyInfoFailureBlock)failure;
@end
