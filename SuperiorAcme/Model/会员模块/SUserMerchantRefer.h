//
//  SUserMerchantRefer.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserMerchantReferSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserMerchantReferFailureBlock) (NSError * error);

@interface SUserMerchantRefer : NSObject
@property (nonatomic, copy) NSString * name;//商户名称
@property (nonatomic, copy) NSString * range_id;//经营范围id
@property (nonatomic, copy) NSString * link_man;//联系人
@property (nonatomic, copy) NSString * link_phone;//联系电话
@property (nonatomic, copy) NSString * job;//职位
@property (nonatomic, copy) NSString * tmail_url;//天猫网店
@property (nonatomic, copy) NSString * jd_url;//京东网店
@property (nonatomic, copy) NSString * other_url;//其他网店链接
@property (nonatomic, copy) NSString * product_desc;//产品描述

@property (nonatomic, strong) NSDictionary * pic_dic;
//@property (nonatomic, strong) UIImage * product_pic;//产品图片(多图) 图片上传拼接格式 product_pic[0] product_pic[1]...
//@property (nonatomic, strong) UIImage * business_license;//营业执照(单图) 图片上传拼接格式 business_license[0]
//@property (nonatomic, strong) UIImage * other_license;//其他证件照片(多图) 图片上传拼接格式 other_license[0] other_license[1] ...

@property (nonatomic, strong) SUserMerchantRefer * data;
@property (nonatomic, copy) NSString * refer_id;//"推荐后的商户id"

- (void)sUserMerchantReferSuccess:(SUserMerchantReferSuccessBlock)success andFailure:(SUserMerchantReferFailureBlock)failure;
@end
