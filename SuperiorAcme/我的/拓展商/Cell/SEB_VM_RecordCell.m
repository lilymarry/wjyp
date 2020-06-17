//
//  SEB_VM_RecordCell.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/20.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SEB_VM_RecordCell.h"

@implementation SEB_VM_RecordCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _headerImage.layer.masksToBounds = YES;
    _headerImage.layer.cornerRadius = 20;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
