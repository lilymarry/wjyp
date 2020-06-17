//
//  SOnlineShop_hotgoodsCell.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2018/12/19.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SOnlineShop_hotgoodsCell.h"

@implementation SOnlineShop_hotgoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _discountLab.layer.masksToBounds = YES;
    _discountLab.layer.cornerRadius =3;
    _discountLab.layer.borderWidth = 0.5;
    _discountLab.layer.borderColor = [UIColor clearColor].CGColor;
}

@end
