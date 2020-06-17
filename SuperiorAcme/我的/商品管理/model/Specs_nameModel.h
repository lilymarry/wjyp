//
//  Specs_nameModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/20.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^Specs_nameModelFailureBlock) (NSError * error);

typedef void(^Specs_nameModelSuccessBlock) (NSString * code, NSString * message,NSArray *arr);

typedef void(^DeleteSpecs_nameModelSuccessBlock) (NSString * code, NSString * message);


typedef void(^UpdateSpecs_nameModelSuccessBlock) (NSString * code, NSString * message);

typedef void(^DeleteSpecs_nameBidModelSuccessBlock) (NSString * code, NSString * message);

@interface Specs_nameModel : NSObject

@property (nonatomic, strong) NSString * goods_id;
@property (nonatomic, strong) NSString * p_id;
@property (nonatomic, strong) NSDictionary * goods_property;
@property (nonatomic, strong) NSString * b_id;
@property ( strong ,nonatomic)NSString *sta_mid; 

- (void)Specs_nameModelSuccess:(Specs_nameModelSuccessBlock)success andFailure:(Specs_nameModelFailureBlock)failure;

- (void)UpdateSpecs_nameModleSuccess:(UpdateSpecs_nameModelSuccessBlock)success andFailure:(Specs_nameModelFailureBlock)failure;

- (void)DeleteSpecs_nameModelSuccess:(DeleteSpecs_nameModelSuccessBlock)success andFailure:(Specs_nameModelFailureBlock)failure;

- (void)DeleteSpecs_nameBidModelSuccess:(DeleteSpecs_nameBidModelSuccessBlock)success andFailure:(Specs_nameModelFailureBlock)failure;



@end

NS_ASSUME_NONNULL_END
