//
//  GetMerchantCate.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/13.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^GetMerchantCateSuccessBlock) (NSString * code, NSString * message, id data);
typedef void (^GetMerchantCateFailureBlock) (NSError * error);
@interface GetMerchantCate : NSObject
@property (nonatomic, copy) NSString * sta_mid;
- (void)GetMerchantCateSuccess:(GetMerchantCateSuccessBlock)success andFailure:(GetMerchantCateFailureBlock)failure;

@end

NS_ASSUME_NONNULL_END
