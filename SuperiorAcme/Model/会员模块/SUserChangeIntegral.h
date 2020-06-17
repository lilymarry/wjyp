//
//  SUserChangeIntegral.h
//  SuperiorAcme
//
//  Created by GYM on 2018/2/24.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserChangeIntegralSuccessBlock) (NSString * code, NSString * message);
typedef void(^SUserChangeIntegralFailureBlock) (NSError * error);

@interface SUserChangeIntegral : NSObject
@property (nonatomic, copy) NSString * integral;//    兑换积分金额

- (void)sUserChangeIntegralSuccess:(SUserChangeIntegralSuccessBlock)success andFailure:(SUserChangeIntegralFailureBlock)failure;
@end
