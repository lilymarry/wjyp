//
//  SCarefreeGradeCell.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/17.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SCarefreeGradeCell.h"

@implementation SCarefreeGradeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _thisR.layer.masksToBounds = YES;
    _thisR.layer.cornerRadius = 15;
    _thisR.layer.borderWidth = 0.5;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
