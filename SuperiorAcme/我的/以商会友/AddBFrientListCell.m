//
//  AddBFrientListCell.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/28.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "AddBFrientListCell.h"

@implementation AddBFrientListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headIma.layer.cornerRadius = self.headIma.bounds.size.width * 0.5;
    self.headIma.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
