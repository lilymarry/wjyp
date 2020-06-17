//
//  SUserEditInfo.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserEditInfoSuccessBlock) (NSString * code, NSString * message);
typedef void(^SUserEditInfoFailureBlock) (NSError * error);

@interface SUserEditInfo : NSObject
@property (nonatomic, copy) NSString * nickname;//昵称
@property (nonatomic, copy) NSString * sex;//姓别 2 女 1男
@property (nonatomic, copy) NSString * email;//邮箱
@property (nonatomic, copy) NSString * province_id;//所在省id
@property (nonatomic, copy) NSString * city_id;//所在市
@property (nonatomic, copy) NSString * area_id;//所在区县
@property (nonatomic, copy) NSString * street_id;//所在街道
@property (nonatomic, strong) UIImage * head_pic;//头像 参数可选

- (void)sUserEditInfoSuccess:(SUserEditInfoSuccessBlock)success andFailure:(SUserEditInfoFailureBlock)failure;
@end
