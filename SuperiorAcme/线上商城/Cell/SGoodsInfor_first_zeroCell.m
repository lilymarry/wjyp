//
//  SGoodsInfor_first_zeroCell.m
//  SuperiorAcme
//
//  Created by GYM on 2017/10/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGoodsInfor_first_zeroCell.h"

@implementation SGoodsInfor_first_zeroCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _lookBtn.layer.masksToBounds = YES;
    _lookBtn.layer.cornerRadius = 3;
    _lookBtn.layer.borderWidth = 0.5;
    _lookBtn.layer.borderColor = [UIColor redColor].CGColor;
}

@end
