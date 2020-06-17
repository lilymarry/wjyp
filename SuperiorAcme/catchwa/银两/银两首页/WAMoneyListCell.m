//
//  WAMoneyListCell.m
//  CatchWAWA
//
//  Created by donkey on 2019/1/5.
//  Copyright © 2019 wotianshiyan. All rights reserved.
//

#import "WAMoneyListCell.h"

@implementation WAMoneyListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _view_back.layer.masksToBounds = YES;
    _view_back.layer.cornerRadius = 5;
    _view_back.layer.borderWidth = 1;
    _view_back.layer.borderColor =[UIColor clearColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
