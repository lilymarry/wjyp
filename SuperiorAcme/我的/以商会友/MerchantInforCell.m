//
//  AddBFrientCell.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/2/27.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "MerchantInforCell.h"

@implementation MerchantInforCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headIconIma.layer.cornerRadius = self.headIconIma.bounds.size.width * 0.5;
    self.headIconIma.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
