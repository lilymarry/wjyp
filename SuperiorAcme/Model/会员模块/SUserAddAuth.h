//
//  SUserAddAuth.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserAddAuthSuccessBlock) (NSString * code, NSString * message);
typedef void(^SUserAddAuthFailureBlock) (NSError * error);

@interface SUserAddAuth : NSObject
@property (nonatomic, copy) NSString * real_name;//真实姓名
@property (nonatomic, copy) NSString * id_card_num;//身份证号
@property (nonatomic, strong) UIImage * id_card_pic;//身份证正面照片

- (void)sUserAddAuthSuccess:(SUserAddAuthSuccessBlock)success andFailure:(SUserAddAuthFailureBlock)failure;
@end
