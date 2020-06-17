//
//  SRegisterRegisterOne.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/23.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SRegisterRegisterOneSuccessBlock) (NSString * code, NSString * message);
typedef void(^SRegisterRegisterOneFailureBlock) (NSError * error);

@interface SRegisterRegisterOne : NSObject
@property (nonatomic, copy) NSString * phone;//手机号

- (void)sRegisterRegisterOneSuccess:(SRegisterRegisterOneSuccessBlock)success andFailure:(SRegisterRegisterOneFailureBlock)failure;
@end
