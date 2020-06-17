//
//  SIndianaInforCell.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/4.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SIndianaInforCell.h"

@implementation SIndianaInforCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _roundR.layer.masksToBounds = YES;
    _roundR.layer.cornerRadius = _roundR.frame.size.width/2;
    
    _headerImage.layer.masksToBounds = YES;
    _headerImage.layer.cornerRadius = _headerImage.frame.size.width/2;
    
    _groundView.layer.masksToBounds = YES;
    _groundView.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
