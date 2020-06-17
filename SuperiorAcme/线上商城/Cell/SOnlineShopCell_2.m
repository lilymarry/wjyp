//
//  SOnlineShopCell_2.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/12.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOnlineShopCell_2.h"

@implementation SOnlineShopCell_2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _songR.layer.masksToBounds = YES;
    _songR.layer.cornerRadius = _songR.frame.size.width/2;
    
    _top_title.layer.masksToBounds = YES;
    _top_title.layer.cornerRadius = 3;
    
    _submit.layer.masksToBounds = YES;
    _submit.layer.cornerRadius = 3;
    
    _header1.layer.masksToBounds = YES;
    _header1.layer.cornerRadius = _header1.frame.size.width/2;
    _header2.layer.masksToBounds = YES;
    _header2.layer.cornerRadius = _header2.frame.size.width/2;
    
//    _country_logo.layer.masksToBounds = YES;
//    _country_logo.layer.cornerRadius = 3;
//    _country_logo.layer.borderWidth = 0.5;
//    _country_logo.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    
    
}

@end
