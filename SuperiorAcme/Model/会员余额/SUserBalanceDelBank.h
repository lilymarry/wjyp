//
//  SUserBalanceDelBank.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserBalanceDelBankSuccessBlock) (NSString * code, NSString * message);
typedef void(^SUserBalanceDelBankFailureBlock) (NSError * error);

@interface SUserBalanceDelBank : NSObject
@property (nonatomic, copy) NSString * bank_card_id;//银行卡id

- (void)sUserBalanceDelBankSuccess:(SUserBalanceDelBankSuccessBlock)success andFailure:(SUserBalanceDelBankFailureBlock)failure;
@end
