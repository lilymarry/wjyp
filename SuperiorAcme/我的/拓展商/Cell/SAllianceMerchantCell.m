//
//  SAllianceMerchantCell.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/18.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SAllianceMerchantCell.h"

@implementation SAllianceMerchantCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _headerImage.layer.masksToBounds = YES;
    _headerImage.layer.cornerRadius = 25;
    
    _thisRBtn.layer.masksToBounds = YES;
    _thisRBtn.layer.cornerRadius = 10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
