//
//  SMessageCell.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/14.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SMessageCell.h"

@implementation SMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _headerImage.layer.masksToBounds = YES;
    _headerImage.layer.cornerRadius = 25;
    
    _headerNum.layer.masksToBounds = YES;
    _headerNum.layer.cornerRadius = 10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
