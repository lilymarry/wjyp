//
//  SDACell.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/18.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SDACell.h"

@implementation SDACell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _thisR.layer.masksToBounds = YES;
    _thisR.layer.cornerRadius = 2;
    _thisRBtn.layer.masksToBounds = YES;
    _thisRBtn.layer.cornerRadius = 2;
    _thisRBtn.layer.borderWidth = 0.5;
    _thisRBtn.layer.borderColor = [UIColor redColor].CGColor;
    _headerImage.layer.masksToBounds = YES;
    _headerImage.layer.cornerRadius = 25;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
