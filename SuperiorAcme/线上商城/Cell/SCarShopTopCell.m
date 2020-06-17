//
//  SCarShopTopCell.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/17.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCarShopTopCell.h"

@implementation SCarShopTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _thisImage.layer.masksToBounds = YES;
    _thisImage.layer.cornerRadius = _thisImage.frame.size.height/2;
//    _thisImage.layer.borderWidth = 1.0;
//    _thisImage.layer.borderColor = [UIColor redColor].CGColor;
}

@end
