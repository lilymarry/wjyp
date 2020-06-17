//
//  ExchangeItemModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/1.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



typedef void(^ExchangeItemModelSuccessBlock) (NSString * code, NSString * message, id data);
typedef void (^ExchangeItemModelFailureBlock) (NSError * error);


@interface ExchangeItemModel : NSObject
@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * sta_mid;

- (void)ExchangeItemModelSuccess:(ExchangeItemModelSuccessBlock)success andFailure:(ExchangeItemModelFailureBlock)failure;


@end

NS_ASSUME_NONNULL_END
