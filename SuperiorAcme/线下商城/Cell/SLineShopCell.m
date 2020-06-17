//
//  SLineShopCell.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SLineShopCell.h"

@implementation SLineShopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _thisR.layer.masksToBounds = YES;
    _thisR.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
