//
//  SCodePackage_twoCell.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/26.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCodePackage_twoCell.h"
#import "CircularProgressView.h"

@implementation SCodePackage_twoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _groundView.layer.masksToBounds = YES;
    _groundView.layer.cornerRadius = 3;
    
    _oneT.layer.masksToBounds = YES;
    _oneT.layer.cornerRadius = 3;
    _twoT.layer.masksToBounds = YES;
    _twoT.layer.cornerRadius = 3;
    _threeT.layer.masksToBounds = YES;
    _threeT.layer.cornerRadius = 3;
    
    _showTimeBtn.layer.masksToBounds = YES;
    _showTimeBtn.layer.cornerRadius = 3;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
