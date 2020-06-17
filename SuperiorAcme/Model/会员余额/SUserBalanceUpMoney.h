//
//  SUserBalanceUpMoney.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserBalanceUpMoneySuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserBalanceUpMoneyFailureBlock) (NSError * error);

@interface SUserBalanceUpMoney : NSObject
@property (nonatomic, copy) NSString * money;//金额
@property (nonatomic, copy) NSString * pay_type;//1微信 2支付宝
@property (nonatomic, copy) NSString * note;//备注
@property (nonatomic, copy) NSString * order_id;

@property (nonatomic, strong) SUserBalanceUpMoney * data;
//@property (nonatomic, copy) NSString * money;//"充值金额",
//@property (nonatomic, copy) NSString * pay_type;// "充值类型" 1微信 2支付宝

- (void)sUserBalanceUpMoneySuccess:(SUserBalanceUpMoneySuccessBlock)success andFailure:(SUserBalanceUpMoneyFailureBlock)failure;
@end
