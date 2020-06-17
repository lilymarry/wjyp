//
//  MemberExchangCell.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/1.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "MemberExchangCell.h"

@implementation MemberExchangCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headIma.layer.cornerRadius = self.headIma.bounds.size.width * 0.5;
    self.headIma.layer.masksToBounds = YES;
    
    self.leveLab.layer.cornerRadius = 8;
    self.leveLab.layer.masksToBounds = YES;
    self.leveLab.layer.borderWidth = 1;
    self.leveLab.layer.borderColor = [UIColor colorWithRed:240/255.0 green:41/255.0 blue:42/255.0 alpha:1].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
