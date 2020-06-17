//
//  SLineShop_footerCell.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SLineShop_footerCell.h"

@implementation SLineShop_footerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _headerImage.layer.borderWidth = 1.0;
    _headerImage.layer.borderColor = MyLine.CGColor;
}

@end
