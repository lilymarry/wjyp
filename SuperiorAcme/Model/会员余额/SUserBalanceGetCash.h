//
//  SUserBalanceGetCash.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserBalanceGetCashSuccessBlock) (NSString * code, NSString * message);
typedef void(^SUserBalanceGetCashFailureBlock) (NSError * error);

@interface SUserBalanceGetCash : NSObject
@property (nonatomic, copy) NSString * pay_password;//支付密码
@property (nonatomic, copy) NSString * money;//金额
@property (nonatomic, copy) NSString * rate;//手续费率
@property (nonatomic, copy) NSString * bank_card_id;//银行卡id

- (void)sUserBalanceGetCashSuccess:(SUserBalanceGetCashSuccessBlock)success andFailure:(SUserBalanceGetCashFailureBlock)failure;
@end
