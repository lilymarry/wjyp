//
//  SUserBalanceGetBankType.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserBalanceGetBankTypeSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserBalanceGetBankTypeFailureBlock) (NSError * error);

@interface SUserBalanceGetBankType : NSObject

@property (nonatomic, copy) NSArray * data;
@property (nonatomic, copy) NSString * bank_type_id;//"类型id",
@property (nonatomic, copy) NSString * bank_name;//"银行名称",
@property (nonatomic, copy) NSString * bank_pic;//"银行图片"

- (void)sUserBalanceGetBankTypeSuccess:(SUserBalanceGetBankTypeSuccessBlock)success andFailure:(SUserBalanceGetBankTypeFailureBlock)failure;
@end
