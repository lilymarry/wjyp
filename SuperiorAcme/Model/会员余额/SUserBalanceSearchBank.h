//
//  SUserBalanceSearchBank.h
//  SuperiorAcme
//
//  Created by GYM on 2018/4/11.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserBalanceSearchBankSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserBalanceSearchBankFailureBlock) (NSError * error);

@interface SUserBalanceSearchBank : NSObject
@property (nonatomic, copy) NSString * bank_name;//    银行名称

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * bank_type_id;//": "118",
//@property (nonatomic, copy) NSString * bank_name;//": "天津银行",
@property (nonatomic, copy) NSString * bank_pic;//": "http://www.wujiemall.com/Uploads/BankPic/118.png"

- (void)sUserBalanceSearchBankSuccess:(SUserBalanceSearchBankSuccessBlock)success andFailure:(SUserBalanceSearchBankFailureBlock)failure;
@end
