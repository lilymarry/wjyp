//
//  SBankAdd.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBankAdd : UIViewController
@property (nonatomic, copy) NSString * bank_card_id;//"银行卡id",
@property (nonatomic, copy) NSString * bank_type_id;//":银行卡类型ID""
@property (nonatomic, copy) NSString * bank_card_code;//银行卡号
@property (nonatomic, copy) NSString * bank_name;//"工商银行",
@property (nonatomic, copy) NSString * open_bank;//": "开户行",
@property (nonatomic, copy) NSString * name;//": "户名"
@property (nonatomic, copy) NSString * phone;//":"手机号码"
@end
