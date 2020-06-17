//
//  SgiftContentCell.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/12.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "MySgiftContentCell.h"

@implementation MySgiftContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.btn_mingxi.layer.borderWidth = 1;
    self.btn_mingxi.layer.borderColor = [UIColor colorWithRed:251/255.0 green:106/255.0 blue:57/255.0 alpha:1].CGColor;
    self.btn_mingxi.layer.masksToBounds = YES;
    self.btn_mingxi.layer.cornerRadius = 12;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)tapDetailClick:(UIButton *)sender {
    if (self.MySgiftContentDetailBtn) {
        self.MySgiftContentDetailBtn();
    }
}
@end
