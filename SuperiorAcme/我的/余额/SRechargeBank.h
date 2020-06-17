//
//  SRechargeBank.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SRechargeBank_choiceBlock) (NSString * bank_card_id, NSString * bank_card_code);

@interface SRechargeBank : UIViewController
@property (nonatomic, assign) BOOL type;//YES平台  NO汇款人

@property (nonatomic, copy) SRechargeBank_choiceBlock SRechargeBank_choice;
@end
