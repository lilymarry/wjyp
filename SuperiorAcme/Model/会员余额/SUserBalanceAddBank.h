//
//  SUserBalanceAddBank.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserBalanceAddBankSuccessBlock) (NSString * code, NSString * message);
typedef void(^SUserBalanceAddBankFailureBlock) (NSError * error);

@interface SUserBalanceAddBank : NSObject
@property (nonatomic, copy) NSString * name;//持卡人姓名
@property (nonatomic, copy) NSString * bank_type_id;//银行卡类型id
@property (nonatomic, copy) NSString * open_bank;//开户行
@property (nonatomic, copy) NSString * card_number;//银行卡号
@property (nonatomic, copy) NSString * phone;//银行预留手机

- (void)sUserBalanceAddBankSuccess:(SUserBalanceAddBankSuccessBlock)success andFailure:(SUserBalanceAddBankFailureBlock)failure;
@end
