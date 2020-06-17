//
//  SOrderManagementCell_sub1.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/9/12.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SOrderManagementCell_sub1.h"

@implementation SOrderManagementCell_sub1

- (void)awakeFromNib {
    [super awakeFromNib];
    self.topViewLeftBtn.layer.borderWidth = 1;
   // self.topViewLeftBtn.layer.borderColor = [UIColor redColor].CGColor;
    self.topViewLeftBtn.layer.masksToBounds = YES;
    self.topViewLeftBtn.layer.cornerRadius = 12;    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
