//
//  SUserShareBack.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/5.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserShareBackSuccessBlock) (NSString * code, NSString * message);
typedef void(^SUserShareBackFailureBlock) (NSError * error);

@interface SUserShareBack : NSObject
@property (nonatomic, copy) NSString * type;//分享类型 1微信 2微博 3qq
@property (nonatomic, copy) NSString * content;//分享内容
@property (nonatomic, copy) NSString * id_val;//对应的id 商品传商品id 依次.... 个人中心的分享id我给你们
@property (nonatomic, copy) NSString * share_type;//1 商品 2商家 3书院 4红包 5其他(个人中心)
@property (nonatomic, copy) NSString * url;//分享链接

- (void)sUserShareBackSuccess:(SUserShareBackSuccessBlock)success andFailure:(SUserShareBackFailureBlock)failure;
@end
