//
//  SShopCouponCell.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/21.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SShopCouponCell.h"

@implementation SShopCouponCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _groundView.layer.masksToBounds = YES;
    _groundView.layer.cornerRadius = 3;
    
    _showTimeBtn.layer.masksToBounds = YES;
    _showTimeBtn.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
