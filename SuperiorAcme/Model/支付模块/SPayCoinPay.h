//
//  SPayCoinPay.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/1/9.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SPayCoinPayPaySuccessBlock) (NSString * code, NSString * message);
typedef void(^SPayCoinPayPayFailureBlock) (NSError * error);

@interface SPayCoinPay : NSObject
@property (nonatomic, copy) NSString * order_id;
@property (nonatomic, copy) NSString * order_type;//     2拼单购

- (void)SPayCoinPayPaySuccess:(SPayCoinPayPaySuccessBlock)success andFailure:(SPayCoinPayPayFailureBlock)failure;
@end


