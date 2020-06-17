//
//  SAddressGetStreet.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SAddressGetStreetSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SAddressGetStreetFailureBlock) (NSError * error);

@interface SAddressGetStreet : NSObject
@property (nonatomic, copy) NSString * area_id;//区县ID

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * street_id;//"街道ID",
@property (nonatomic, copy) NSString * street_name;//"街道名称"

- (void)sAddressGetStreetSuccess:(SAddressGetStreetSuccessBlock)success andFailure:(SAddressGetStreetFailureBlock)failure;
@end
