//
//  SWelfareAgencyCell.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SWelfareAgencyCell.h"

@implementation SWelfareAgencyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _thisImage.layer.masksToBounds = YES;
    _thisImage.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
