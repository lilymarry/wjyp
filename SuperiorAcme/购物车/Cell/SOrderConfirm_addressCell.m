//
//  SOrderConfirm_addressCell.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOrderConfirm_addressCell.h"

@implementation SOrderConfirm_addressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _thisR.layer.masksToBounds = YES;
    _thisR.layer.cornerRadius = _thisR.frame.size.width/2;
    
    _callTitle.layer.masksToBounds = YES;
    _callTitle.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
