//
//  SListedIncubation_inforCell.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SListedIncubation_inforCell.h"

@implementation SListedIncubation_inforCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _rightR.layer.masksToBounds = YES;
    _rightR.layer.cornerRadius = 3;
    _rightR.layer.borderWidth = 1.0;
    _rightR.layer.borderColor = MyLine.CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
