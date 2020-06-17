//
//  CsCell3.m
//  TaoMiShop
//
//  Created by TXD_air on 16/10/22.
//  Copyright © 2016年 zhaobaofeng. All rights reserved.
//

#import "CsCell3.h"

@implementation CsCell3

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _grayView.layer.masksToBounds = YES;
    _grayView.layer.cornerRadius = 15;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
