//
//  SGoodsInforCell2.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/19.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGoodsInforCell2.h"

@implementation SGoodsInforCell2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _roundR.layer.masksToBounds = YES;
    _roundR.layer.cornerRadius = _roundR.frame.size.width/2;
    
    _rightR.layer.masksToBounds = YES;
    _rightR.layer.cornerRadius = 3;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
