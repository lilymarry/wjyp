//
//  SEB_VM_CCell.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/18.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SEB_VM_CCell.h"

@implementation SEB_VM_CCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _thisR.layer.masksToBounds = YES;
    _thisR.layer.cornerRadius = 3;
    
    _headerImage.layer.masksToBounds = YES;
    _headerImage.layer.cornerRadius = 25;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
