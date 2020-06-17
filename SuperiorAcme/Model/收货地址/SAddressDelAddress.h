//
//  SAddressDelAddress.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SAddressDelAddressSuccessBlock) (NSString * code, NSString * message);
typedef void(^SAddressDelAddressFailureBlock) (NSError * error);

@interface SAddressDelAddress : NSObject
@property (nonatomic, copy) NSString * address_id;//地址id

- (void)sAddressDelAddressSuccess:(SAddressDelAddressSuccessBlock)success andFailure:(SAddressDelAddressFailureBlock)failure;
@end
