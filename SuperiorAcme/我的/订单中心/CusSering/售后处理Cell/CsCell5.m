//
//  CsCell5.m
//  TaoMiShop
//
//  Created by TXD_air on 16/10/22.
//  Copyright © 2016年 zhaobaofeng. All rights reserved.
//

#import "CsCell5.h"

@implementation CsCell5

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _blueView.layer.masksToBounds = YES;
    _blueView.layer.cornerRadius = 15;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
