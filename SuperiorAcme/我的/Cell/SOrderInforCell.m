//
//  SOrderInforCell.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOrderInforCell.h"

@implementation SOrderInforCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _submitBtn.layer.masksToBounds = YES;
    _submitBtn.layer.cornerRadius = 15;
    _submitBtn.layer.borderWidth = 1.0;
    _submitBtn.layer.borderColor = WordColor_sub_sub_sub.CGColor;
    
    _comeBtn.layer.masksToBounds = YES;
    _comeBtn.layer.cornerRadius = 15;
    _comeBtn.layer.borderWidth = 1.0;
    _comeBtn.layer.borderColor = [UIColor redColor].CGColor;
    
    _againBtn.layer.masksToBounds = YES;
    _againBtn.layer.cornerRadius = 15;
    _againBtn.layer.borderWidth = 1.0;
    _againBtn.layer.borderColor = [UIColor redColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
