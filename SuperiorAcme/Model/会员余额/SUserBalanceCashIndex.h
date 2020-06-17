//
//  SUserBalanceCashIndex.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserBalanceCashIndexSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserBalanceCashIndexFailureBlock) (NSError * error);

@interface SUserBalanceCashIndex : NSObject

@property (nonatomic, strong) SUserBalanceCashIndex * data;
@property (nonatomic, copy) NSString * balance;//": "余额",
@property (nonatomic, copy) NSString * rate;//": "10",手续费率
@property (nonatomic, copy) NSString * delay_time;//": "三个工作日内"//到账日期

- (void)sUserBalanceCashIndexSuccess:(SUserBalanceCashIndexSuccessBlock)success andFailure:(SUserBalanceCashIndexFailureBlock)failure;
@end
