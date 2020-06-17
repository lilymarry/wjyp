//
//  SOnlineShopCell_house.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/17.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOnlineShopCell_house.h"

@implementation SOnlineShopCell_house

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _integral_R.layer.masksToBounds = YES;
    _integral_R.layer.cornerRadius = _integral_R.frame.size.width/2;
    _top_oneTitle.layer.masksToBounds = YES;
    _top_oneTitle.layer.cornerRadius = 3;
    _red_pro.layer.masksToBounds = YES;
    _red_pro.layer.cornerRadius =3;
    _car_R.layer.masksToBounds = YES;
    _car_R.layer.cornerRadius =3;
    
//    _country_logo.layer.masksToBounds = YES;
//    _country_logo.layer.cornerRadius = 3;
//    _country_logo.layer.borderWidth = 0.5;
//    _country_logo.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
}

@end
