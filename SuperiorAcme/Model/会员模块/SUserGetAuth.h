//
//  SUserGetAuth.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserGetAuthSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserGetAuthFailureBlock) (NSError * error);

@interface SUserGetAuth : NSObject

@property (nonatomic, strong) SUserGetAuth * data;
@property (nonatomic, copy) NSString * real_name;//"真实姓名",
@property (nonatomic, copy) NSString * id_card_num;//"身份证号",
@property (nonatomic, copy) NSString * id_card_pic;//"身份证照片",
@property (nonatomic, copy) NSString * auth_status;//"认证状态 // 0 未认证 1认证中 2已认证 3认证失败

- (void)sUserGetAuthSuccess:(SUserGetAuthSuccessBlock)success andFailure:(SUserGetAuthFailureBlock)failure;
@end
