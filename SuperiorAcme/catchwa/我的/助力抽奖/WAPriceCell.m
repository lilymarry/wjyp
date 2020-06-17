//
//  WAPriceCell.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/16.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAPriceCell.h"

@implementation WAPriceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _headIma.layer.masksToBounds = YES;
    _headIma.layer.cornerRadius = _headIma.frame.size.width/2;
    _headIma.layer.borderWidth = 1;
    _headIma.layer.borderColor =[UIColor clearColor].CGColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
