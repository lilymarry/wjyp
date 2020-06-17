//
//  SUserChangeIntegralStatus.h
//  SuperiorAcme
//
//  Created by GYM on 2018/2/24.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserChangeIntegralStatusSuccessBlock) (NSString * code, NSString * message);
typedef void(^SUserChangeIntegralStatusFailureBlock) (NSError * error);

@interface SUserChangeIntegralStatus : NSObject
@property (nonatomic, copy) NSString * status;//    自动兑换状态（0->关闭，1->开启）

- (void)sUserChangeIntegralStatusSuccess:(SUserChangeIntegralStatusSuccessBlock)success andFailure:(SUserChangeIntegralStatusFailureBlock)failure;
@end
