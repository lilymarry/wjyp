//
//  GoodsManager_rightCell.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/1/22.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "GoodsManager_rightCell.h"

@implementation GoodsManager_rightCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.qishouLab.layer.masksToBounds = YES;
    self.qishouLab.layer.cornerRadius = 10;
    self.qishouLab.layer.borderWidth = 0.1;
    self.qishouLab.layer.borderColor = [UIColor clearColor].CGColor;
    
    self.guigeLab.layer.masksToBounds = YES;
    self.guigeLab.layer.cornerRadius = 10;
    self.guigeLab.layer.borderWidth = 0.1;
    self.guigeLab.layer.borderColor = [UIColor clearColor].CGColor;
    
}

@end
