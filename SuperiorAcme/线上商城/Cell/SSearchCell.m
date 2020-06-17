//
//  SSearchCell.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/14.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SSearchCell.h"

@implementation SSearchCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _thisTitle.layer.masksToBounds = YES;
    _thisTitle.layer.cornerRadius = 3;
}

@end
