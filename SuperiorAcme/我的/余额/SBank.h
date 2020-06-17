//
//  SBank.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SBank_choiceBlock) (NSString * bank_card_id, NSString * bank_card_code);

@interface SBank : UIViewController
@property (nonatomic, assign) BOOL choice_isno;//NO删除 YES选取返回

@property (nonatomic, copy) SBank_choiceBlock SBank_choice;
@end
