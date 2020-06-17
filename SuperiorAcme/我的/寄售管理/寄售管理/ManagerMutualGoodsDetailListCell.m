//
//  ManagerMutualGoodsDetailTopCell.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/10.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "ManagerMutualGoodsDetailListCell.h"

@implementation ManagerMutualGoodsDetailListCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.jishouBtn.layer.borderWidth = 1;
    self.jishouBtn.layer.borderColor = [UIColor colorWithRed:250/255.0 green:85/255.0 blue:84/255.0 alpha:1].CGColor;
    self.jishouBtn.layer.masksToBounds = YES;
    self.jishouBtn.layer.cornerRadius = 12;
    
    self.discountLab.layer.borderWidth = 1;
    self.discountLab.layer.borderColor = [UIColor colorWithRed:236/255.0 green:90/255.0 blue:32/255.0 alpha:1].CGColor;
    self.discountLab.layer.cornerRadius = 2;
    self.discountLab.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
