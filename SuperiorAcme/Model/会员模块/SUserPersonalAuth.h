//
//  SUserPersonalAuth.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserPersonalAuthSuccessBlock) (NSString * code, NSString * message);
typedef void(^SUserPersonalAuthFailureBlock) (NSError * error);

@interface SUserPersonalAuth : NSObject
@property (nonatomic, copy) NSString * real_name;//    真实姓名    否    文本    未提供
@property (nonatomic, copy) NSString * sex;//    1 男 2女    否    文本    未提供
@property (nonatomic, copy) NSString * id_card_num;//    身份证号    否    文本    未提供
@property (nonatomic, copy) NSString * card_start_time;//    身份证有效期开始时间    否    文本    未提供
@property (nonatomic, copy) NSString * card_end_time;//    身份证有效期结束时间    否    文本    未提供
@property (nonatomic, copy) NSString * auth_province_id;//    个人认证省id    否    文本    未提供
@property (nonatomic, copy) NSString * auth_city_id;//    个人认证 城市id    否    文本    未提供
@property (nonatomic, copy) NSString * auth_area_id;//    个人认证地区id    否    文本    未提供
@property (nonatomic, copy) NSString * auth_street_id;//    个人认证街道id    否    文本    未提供
@property (nonatomic, strong) UIImage * positive_id_card;//    身份证正面照片    否    文本    未提供
@property (nonatomic, strong) UIImage * back_id_card;//    身份证背面照片

- (void)sUserPersonalAuthSuccess:(SUserPersonalAuthSuccessBlock)success andFailure:(SUserPersonalAuthFailureBlock)failure;
@end
