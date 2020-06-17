//
//  SUserBalanceChangeMoney.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserBalanceChangeMoneySuccessBlock) (NSString * code, NSString * message);
typedef void(^SUserBalanceChangeMoneyFailureBlock) (NSError * error);

@interface SUserBalanceChangeMoney : NSObject
@property (nonatomic, copy) NSString * code;//对方电话 或者 会员ID
@property (nonatomic, copy) NSString * money;//转账金额
@property (nonatomic, copy) NSString * real_name;//对方姓名
@property (nonatomic, copy) NSString * pay_password;//支付密码

- (void)sUserBalanceChangeMoneySuccess:(SUserBalanceChangeMoneySuccessBlock)success andFailure:(SUserBalanceChangeMoneyFailureBlock)failure;
@end
