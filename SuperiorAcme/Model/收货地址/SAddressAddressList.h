//
//  SAddressAddressList.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SAddressAddressListSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SAddressAddressListFailureBlock) (NSError * error);

@interface SAddressAddressList : NSObject
@property (nonatomic, copy) NSString * p;//分页参数

@property (nonatomic, strong) SAddressAddressList * data;

//默认收货地址
@property (nonatomic, strong) SAddressAddressList * default_address;
@property (nonatomic, copy) NSString * address_id;//"地址id",
@property (nonatomic, copy) NSString * receiver;//"收货人",
@property (nonatomic, copy) NSString * phone;//"收货人电话",
@property (nonatomic, copy) NSString * province;//"省",
@property (nonatomic, copy) NSString * city;//"市",
@property (nonatomic, copy) NSString * area;//"区",
@property (nonatomic, copy) NSString * street;//"街道",
@property (nonatomic, copy) NSString * address;//"详细地址",
@property (nonatomic, copy) NSString * lng;//"经度",
@property (nonatomic, copy) NSString * lat;//"纬度",

@property (nonatomic, copy) NSArray * common_address;//收货地址列表
//@property (nonatomic, copy) NSString * address_id;//"地址id",
//@property (nonatomic, copy) NSString * receiver;//"收货人",
//@property (nonatomic, copy) NSString * phone;//"收货人电话",
//@property (nonatomic, copy) NSString * province;//"省",
//@property (nonatomic, copy) NSString * city;//"市",
//@property (nonatomic, copy) NSString * area;//"区",
//@property (nonatomic, copy) NSString * street;//"街道",
//@property (nonatomic, copy) NSString * address;//"详细地址",
//@property (nonatomic, copy) NSString * lng;//"经度",
//@property (nonatomic, copy) NSString * lat;//"纬度",
//@property (nonatomic, copy) NSString * is_default;//是否默认 0否 1是

- (void)sAddressAddressListSuccess:(SAddressAddressListSuccessBlock)success andFailure:(SAddressAddressListFailureBlock)failure;
@end
