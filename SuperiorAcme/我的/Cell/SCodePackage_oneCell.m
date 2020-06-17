//
//  SCodePackage_oneCell.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/26.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCodePackage_oneCell.h"

@implementation SCodePackage_oneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _headerImage.layer.masksToBounds = YES;
    _headerImage.layer.cornerRadius = _headerImage.frame.size.width/2;
    
    _groundView.layer.masksToBounds = YES;
    _groundView.layer.cornerRadius = 3;
    
    _rightR.layer.masksToBounds = YES;
    _rightR.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
