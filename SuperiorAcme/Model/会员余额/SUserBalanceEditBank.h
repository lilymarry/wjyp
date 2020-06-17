//
//  SUserBalanceEditBank.h
//  SuperiorAcme
//
//  Created by GYM on 2018/3/9.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserBalanceEditBankSuccessBlock) (NSString * code, NSString * message);
typedef void(^SUserBalanceEditBankFailureBlock) (NSError * error);

@interface SUserBalanceEditBank : NSObject
@property (nonatomic, copy) NSString * bank_card_id;//    银行卡ID    否    文本    1
@property (nonatomic, copy) NSString * name;//    插卡人姓名    否    文本    张三
@property (nonatomic, copy) NSString * bank_type_id;//    银行卡类型ID    否    文本    1
@property (nonatomic, copy) NSString * open_bank;//    开户行    否    文本    123456
@property (nonatomic, copy) NSString * card_number;//    银行卡卡号    否    文本    123***8
@property (nonatomic, copy) NSString * phone;//   预留手机号

- (void)sUserBalanceEditBankSuccess:(SUserBalanceEditBankSuccessBlock)success andFailure:(SUserBalanceEditBankFailureBlock)failure;
@end
