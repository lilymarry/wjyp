//
//  SAddressSetDefault.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SAddressSetDefaultSuccessBlock) (NSString * code, NSString * message);
typedef void(^SAddressSetDefaultFailureBlock) (NSError * error);

@interface SAddressSetDefault : NSObject
@property (nonatomic, copy) NSString * address_id;//收货地址id

- (void)sAddressSetDefaultSuccess:(SAddressSetDefaultSuccessBlock)success andFailure:(SAddressSetDefaultFailureBlock)failure;
@end
