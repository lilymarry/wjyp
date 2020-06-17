//
//  AttrNameModle.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/20.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^AttrNameModleFailureBlock) (NSError * error);

typedef void(^AttrNameModleSuccessBlock) (NSString * code, NSString * message,NSArray *arr);

typedef void(^UpdateAttrNameModleSuccessBlock) (NSString * code, NSString * message);

typedef void(^DeleteAttrNameModleSuccessBlock) (NSString * code, NSString * message);

@interface AttrNameModle : NSObject

@property (nonatomic, strong) NSString * goods_id;
@property (nonatomic, strong) NSString * sta_mid;
@property (nonatomic, strong) NSArray * attr;
@property (nonatomic, strong) NSString * attr_id;


- (void)AttrNameModleSuccess:(AttrNameModleSuccessBlock)success andFailure:(AttrNameModleFailureBlock)failure;

- (void)UpdateAttrNameModleSuccess:(UpdateAttrNameModleSuccessBlock)success andFailure:(AttrNameModleFailureBlock)failure;

- (void)DeleteAttrNameModleSuccess:(DeleteAttrNameModleSuccessBlock)success andFailure:(AttrNameModleFailureBlock)failure;

@end

NS_ASSUME_NONNULL_END
