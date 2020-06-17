//
//  SUserBalanceGetUnderInfo.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/23.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SUserBalanceGetUnderInfoSuccessBlock) (NSString * code, NSString * message, id data);
typedef void(^SUserBalanceGetUnderInfoFailureBlock) (NSError * error);

@interface SUserBalanceGetUnderInfo : NSObject
@property (nonatomic, copy) NSString * act_id;//线下充值id

@property (nonatomic, strong) SUserBalanceGetUnderInfo * data;
@property (nonatomic, copy) NSString * id;//": "1",
@property (nonatomic, copy) NSString * status;//": "2",//状态 0审核中 1已完成 2已拒绝
@property (nonatomic, copy) NSString * bank_card_id;//": "银行卡id",
@property (nonatomic, copy) NSString * act_time;//": "汇款时间",
@property (nonatomic, copy) NSString * money;//": "汇款金额",
@property (nonatomic, copy) NSString * name;//": "汇款人",
@property (nonatomic, copy) NSString * pic;//": "汇款凭证",
@property (nonatomic, copy) NSString * desc;//": "汇款描述",
@property (nonatomic, copy) NSString * card_number;//": "63214523651450035",//银行卡号
@property (nonatomic, copy) NSString * open_bank;//": "饮水道分行",//开户行
@property (nonatomic, copy) NSString * card_name;//": "张宝安"//户名
@property (nonatomic, copy) NSString * refuse_desc;//":"拒绝理由"
@property (nonatomic, copy) NSString * p_bank_num;//": "63214523651450035",//平台银行卡号
@property (nonatomic, copy) NSString * p_bank_name;//": "饮水道分行",//平台户名
@property (nonatomic, copy) NSString * p_open_bank;//": "张宝安"//平台开户行

- (void)sUserBalanceGetUnderInfoSuccess:(SUserBalanceGetUnderInfoSuccessBlock)success andFailure:(SUserBalanceGetUnderInfoFailureBlock)failure;
@end
