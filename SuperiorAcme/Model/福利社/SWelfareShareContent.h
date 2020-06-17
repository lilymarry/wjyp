//
//  SWelfareShareContent.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/28.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SWelfareShareContentSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SWelfareShareContentFailureBlock) (NSError * error);

@interface SWelfareShareContent : NSObject
@property (nonatomic, copy) NSString * bonus_id;//红包id

@property (nonatomic, strong) SWelfareShareContent * data;
@property (nonatomic, copy) NSString * id_val;//": "红包id",
@property (nonatomic, copy) NSString * title;//": "分享标题",
@property (nonatomic, copy) NSString * content;//": "分享内容",
@property (nonatomic, copy) NSString * pic;//": "分享图片",
@property (nonatomic, copy) NSString * url;//": "分享链接",
@property (nonatomic, copy) NSString * share_type;//": "分享内容类型 "1 商品 2商家 3书院 4红包 5其他

- (void)sWelfareShareContentSuccess:(SWelfareShareContentSuccessBlock)success andFailure:(SWelfareShareContentFailureBlock)failure;
@end
