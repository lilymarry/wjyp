//
//  SAddressGetOneAddress.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SAddressGetOneAddressSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SAddressGetOneAddressFailureBlock) (NSError * error);

@interface SAddressGetOneAddress : NSObject
@property (nonatomic, copy) NSString * address_id;//收货地址id

@property (nonatomic, strong) SAddressGetOneAddress * data;
@property (nonatomic, copy) NSString * id;//"地址id",
@property (nonatomic, copy) NSString * user_id;//"用户id",
@property (nonatomic, copy) NSString * receiver;//"收货人",
@property (nonatomic, copy) NSString * phone;//"收货人电话",
@property (nonatomic, copy) NSString * province;// "省",
@property (nonatomic, copy) NSString * city;//"市",
@property (nonatomic, copy) NSString * area;//"区",
@property (nonatomic, copy) NSString * street;//"街道",
@property (nonatomic, copy) NSString * province_id;//"省ID",
@property (nonatomic, copy) NSString * city_id;//"市ID",
@property (nonatomic, copy) NSString * area_id;//"区ID",
@property (nonatomic, copy) NSString * street_id;//"街道ID",
@property (nonatomic, copy) NSString * address;//"详细地址",
@property (nonatomic, copy) NSString * lng;//"经度",
@property (nonatomic, copy) NSString * lat;//"纬度",
@property (nonatomic, copy) NSString * is_default;//是否默认 0否 1是
@property (nonatomic, copy) NSString * create_time;//"添加时间"

- (void)sAddressGetOneAddressSuccess:(SAddressGetOneAddressSuccessBlock)success andFailure:(SAddressGetOneAddressFailureBlock)failure;
@end
