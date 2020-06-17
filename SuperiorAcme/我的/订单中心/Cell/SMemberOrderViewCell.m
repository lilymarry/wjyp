//
//  SMemberOrderViewCell.m
//  SuperiorAcme
//
//  Created by GYM on 2018/3/13.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SMemberOrderViewCell.h"

@implementation SMemberOrderViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _oneBtn.layer.masksToBounds = YES;
    _oneBtn.layer.cornerRadius = 15;
    _oneBtn.layer.borderWidth = 0.5;
    _oneBtn.layer.borderColor = WordColor_30.CGColor;
    _twoBtn.layer.masksToBounds = YES;
    _twoBtn.layer.cornerRadius = 15;
    _twoBtn.layer.borderWidth = 0.5;
    _twoBtn.layer.borderColor = [UIColor redColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
