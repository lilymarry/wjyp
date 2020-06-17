//
//  SUserBalanceUnderMoney.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserBalanceUnderMoneySuccessBlock) (NSString * code, NSString * message);
typedef void(^SUserBalanceUnderMoneyFailureBlock) (NSError * error);

@interface SUserBalanceUnderMoney : NSObject
@property (nonatomic, copy) NSString * bank_card_id;//汇款银行卡id
@property (nonatomic, copy) NSString * act_time;//汇款时间 时间戳
@property (nonatomic, copy) NSString * money;//汇款金额
@property (nonatomic, copy) NSString * name;//汇款人
@property (nonatomic, strong) UIImage * pic;//汇款凭证
@property (nonatomic, copy) NSString * desc;//汇款说明
@property (nonatomic, copy) NSString * pay_password;//支付密码
@property (nonatomic, copy) NSString * platform_account_id;//    平台银行卡ID

- (void)sUserBalanceUnderMoneySuccess:(SUserBalanceUnderMoneySuccessBlock)success andFailure:(SUserBalanceUnderMoneyFailureBlock)failure;
@end
