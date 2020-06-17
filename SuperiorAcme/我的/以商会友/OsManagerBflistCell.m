//
//  OsManagerBflistCell.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/26.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "OsManagerBflistCell.h"

@implementation OsManagerBflistCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headIma.layer.cornerRadius = self.headIma.bounds.size.width * 0.5;
    self.headIma.layer.masksToBounds = YES;
    
    self.friendLab.layer.cornerRadius = 8;
    self.friendLab.layer.masksToBounds = YES;
    self.friendLab.layer.borderWidth = 1;
    self.friendLab.layer.borderColor = [UIColor colorWithRed:240/255.0 green:41/255.0 blue:42/255.0 alpha:1].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
