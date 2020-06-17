//
//  SUserAddPoint.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserAddPointSuccessBlock) (NSString * code, NSString * message);
typedef void(^SUserAddPointFailureBlock) (NSError * error);

@interface SUserAddPoint : NSObject
@property (nonatomic, copy) NSString * reason;//原因
@property (nonatomic, copy) NSString * get_point;//成长值

- (void)sUserAddPointSuccess:(SUserAddPointSuccessBlock)success andFailure:(SUserAddPointFailureBlock)failure;
@end
