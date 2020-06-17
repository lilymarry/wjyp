//
//  SIndianaInfor_threeCell.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/19.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SIndianaInfor_threeCell.h"

@implementation SIndianaInfor_threeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _head_pic.layer.masksToBounds = YES;
    _head_pic.layer.cornerRadius = _head_pic.frame.size.width/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
