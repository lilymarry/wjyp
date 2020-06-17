//
//  SUserCompAuth.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserCompAuthSuccessBlock) (NSString * code, NSString * message);
typedef void(^SUserCompAuthFailureBlock) (NSError * error);

@interface SUserCompAuth : NSObject
@property (nonatomic, copy) NSString * com_name;//    企业名称    否    文本    未提供
@property (nonatomic, copy) NSString * comp_reg_num;//    注册号    否    文本    未提供
@property (nonatomic, copy) NSString * comp_start_time;//    营业开始时间    否    文本    未提供
@property (nonatomic, copy) NSString * comp_end_time;//    营业截止时间    否    文本    未提供
@property (nonatomic, copy) NSString * comp_province_id;//    企业认证省份id    否    文本    未提供
@property (nonatomic, copy) NSString * comp_city_id;//    企业认证城市id    否    文本    未提供
@property (nonatomic, copy) NSString * comp_area_id;//    企业认证地区id    否    文本    未提供
@property (nonatomic, copy) NSString * comp_street_id;//    企业认证地区id    否    文本    未提供
@property (nonatomic, strong) UIImage * comp_business_license;//    营业执照照片

- (void)sUserCompAuthSuccess:(SUserCompAuthSuccessBlock)success andFailure:(SUserCompAuthFailureBlock)failure;
@end
