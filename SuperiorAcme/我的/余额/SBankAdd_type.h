//
//  SBankAdd_type.h
//  SuperiorAcme
//
//  Created by GYM on 2017/9/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SBankAdd_type_choiceBlock) (NSString * bank_type_id, NSString * bank_name);

@interface SBankAdd_type : UIViewController

@property (nonatomic, copy) SBankAdd_type_choiceBlock SBankAdd_type_choice;
@end
