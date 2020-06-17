//
//  SAddressEditAddress.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SAddressEditAddressSuccessBlock) (NSString * code, NSString * message);
typedef void(^SAddressEditAddressFailureBlock) (NSError * error);

@interface SAddressEditAddress : NSObject
@property (nonatomic, copy) NSString * address_id;//地址ID
@property (nonatomic, copy) NSString * receiver;//收货人
@property (nonatomic, copy) NSString * phone;//收货人联系方式
@property (nonatomic, copy) NSString * province;//省
@property (nonatomic, copy) NSString * city;//市
@property (nonatomic, copy) NSString * area;//区
@property (nonatomic, copy) NSString * street;//街道
@property (nonatomic, copy) NSString * province_id;//省id
@property (nonatomic, copy) NSString * city_id;//市id
@property (nonatomic, copy) NSString * area_id;//区id
@property (nonatomic, copy) NSString * street_id;//街道id
@property (nonatomic, copy) NSString * address;//详细地址
@property (nonatomic, copy) NSString * lng;//经度
@property (nonatomic, copy) NSString * lat;//纬度

- (void)sAddressEditAddressSuccess:(SAddressEditAddressSuccessBlock)success andFailure:(SAddressEditAddressFailureBlock)failure;
@end
