///Users/tianjinwotiankeji/Desktop/wujie_ios_test 6  git/SuperiorAcme
//  SgiftTop_viewCell.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/10/12.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "MySgiftTop_viewCell.h"

@implementation MySgiftTop_viewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)tapChangMoneyClick:(UIButton *)sender {
    if (self.mySgiftChangeMoneyBtnBlock) {
        self.mySgiftChangeMoneyBtnBlock();
    }
}
@end
