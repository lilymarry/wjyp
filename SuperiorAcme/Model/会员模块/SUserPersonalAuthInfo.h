//
//  SUserPersonalAuthInfo.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserPersonalAuthInfoSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserPersonalAuthInfoFailureBlock) (NSError * error);

@interface SUserPersonalAuthInfo : NSObject

@property (nonatomic, strong) SUserPersonalAuthInfo * data;
@property (nonatomic, copy) NSString * real_name;//": "真实姓名",
@property (nonatomic, copy) NSString * sex;//": "性别 1男 2女",
@property (nonatomic, copy) NSString * id_card_num;//": "身份证号",
@property (nonatomic, copy) NSString * id_card_start_time;//": "身份证有效期开始时间" 如果为0表示永久 时间戳,
@property (nonatomic, copy) NSString * id_card_start_date;
@property (nonatomic, copy) NSString * id_card_end_time;//": "身份证有效期截止时间",如果为0镖师永久 时间戳
@property (nonatomic, copy) NSString * id_card_end_date;

@property (nonatomic, copy) NSString * auth_province_id;//": "0",省ID
@property (nonatomic, copy) NSString * auth_city_id;//": "0",市ID
@property (nonatomic, copy) NSString * auth_area_id;//": "0",地区ID
@property (nonatomic, copy) NSString * auth_street_id;//": "0",街道ID
@property (nonatomic, copy) NSString * positive_id_card;//": "",//身份证正面照
@property (nonatomic, copy) NSString * back_id_card;//": "",//身份证背面照
@property (nonatomic, copy) NSString * auth_status;//": "0",//认证状态 0未认证 1认证中 2已认证 3拒绝
@property (nonatomic, copy) NSString * auth_province_name;//": "",省名称
@property (nonatomic, copy) NSString * auth_city_name;//": "",市名称
@property (nonatomic, copy) NSString * auth_area_name;//": "",//地区名称
@property (nonatomic, copy) NSString * auth_street_name;//": ""//街道名称
@property (nonatomic, copy) NSString * auth_desc;//": ""//个人认证拒绝原因

@property (nonatomic, copy) NSString * com_name;//": "",企业名称
@property (nonatomic, copy) NSString * comp_reg_num;//": "",注册号
@property (nonatomic, copy) NSString * comp_start_time;//": "0",营业开始时间
@property (nonatomic, copy) NSString * comp_start_date;
@property (nonatomic, copy) NSString * comp_end_time;//": "0",营业截止时间
@property (nonatomic, copy) NSString * comp_end_date;
@property (nonatomic, copy) NSString * comp_province_id;//": "0",企业认证省份id
@property (nonatomic, copy) NSString * comp_city_id;//": "0",企业认证城市id
@property (nonatomic, copy) NSString * comp_area_id;//": "0",企业认证地区id
@property (nonatomic, copy) NSString * comp_street_id;//": "0",企业认证街道ID
@property (nonatomic, copy) NSString * comp_business_license;//": "",营业执照照片
@property (nonatomic, copy) NSString * comp_auth_status;//": "0",认证状态 0未认证 1认证中 2已认证 3拒绝
@property (nonatomic, copy) NSString * comp_province_name;//": "",企业认证省份名称
@property (nonatomic, copy) NSString * comp_city_name;//": "",企业认证城市名称
@property (nonatomic, copy) NSString * comp_area_name;//": "",企业认证地区名称
@property (nonatomic, copy) NSString * comp_street_name;//": ""企业认证街道名称
@property (nonatomic, copy) NSString * comp_desc;//": ""//企业认证拒绝原因

- (void)sUserPersonalAuthInfoSuccess:(SUserPersonalAuthInfoSuccessBlock)success andFailure:(SUserPersonalAuthInfoFailureBlock)failure;
@end
