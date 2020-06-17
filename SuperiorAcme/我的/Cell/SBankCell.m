//
//  SBankCell.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/25.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SBankCell.h"

@implementation SBankCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _groImage.layer.masksToBounds = YES;
    _groImage.layer.cornerRadius = 5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
