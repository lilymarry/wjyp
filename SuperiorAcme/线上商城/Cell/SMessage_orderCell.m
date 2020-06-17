//
//  SMessage_orderCell.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/14.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SMessage_orderCell.h"

@implementation SMessage_orderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _ground.layer.masksToBounds = YES;
    _ground.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
