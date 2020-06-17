//
//  SBankCell.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SBankCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *bank_pic;
@property (strong, nonatomic) IBOutlet UILabel *bank_name;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bank_name_WWW;

@property (strong, nonatomic) IBOutlet UILabel *bank_card_code;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bank_card_code_WWW;
@property (weak, nonatomic) IBOutlet UIImageView *groImage;
@property (weak, nonatomic) IBOutlet UIButton *oneBtn;
@property (weak, nonatomic) IBOutlet UIButton *twoBtn;
@end
