//
//  GoodsManager_headCell.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/1/23.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "GoodsManager_headCell.h"

@implementation GoodsManager_headCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.allBtn.layer.cornerRadius = 15;
    self.allBtn.layer.borderWidth = 1;
    self.allBtn.layer.borderColor = [UIColor colorWithRed:247/255.0 green:76/255.0 blue:11/255.0 alpha:1].CGColor;
}

@end
