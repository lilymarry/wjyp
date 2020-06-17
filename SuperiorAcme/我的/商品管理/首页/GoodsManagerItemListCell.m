//
//  GoodsManagerItemListCell.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/1/23.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "GoodsManagerItemListCell.h"

@implementation GoodsManagerItemListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bianjibtn.layer.masksToBounds = YES;
    self.bianjibtn.layer.cornerRadius = 5;
    self.bianjibtn.layer.borderWidth = 0.1;
    self.bianjibtn.layer.borderColor = [UIColor clearColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)bianJIPress:(id)sender {
   
    self.topBtnBlock(_model);
}

@end
