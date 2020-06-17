//
//  SEvaCarCell.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/30.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SEvaCarCell.h"

@implementation SEvaCarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _choiceBtn.layer.masksToBounds = YES;
    _choiceBtn.layer.cornerRadius = 3;
}

@end
