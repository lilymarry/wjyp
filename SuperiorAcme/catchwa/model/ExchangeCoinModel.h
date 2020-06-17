//
//  ExchangeCoinModel.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/2.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ExchangeCoinModelSuccessBlock) (NSString * code, NSString * message,NSDictionary *coinDic);

typedef void(^ExchangeCoinModelFailureBlock) (NSError * error);

@interface ExchangeCoinModel : NSObject
@property(copy ,nonatomic)NSString *   cid ;
@property(copy ,nonatomic)NSString *   times ;

- (void)ExchangeCoinModelSuccess:(ExchangeCoinModelSuccessBlock)success andFailure:(ExchangeCoinModelFailureBlock)failure;
@end

NS_ASSUME_NONNULL_END
