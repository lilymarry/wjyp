//
//  WAInRoomCell.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/21.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAInRoomCell.h"

@implementation WAInRoomCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _numlab.layer.masksToBounds = YES;
    _numlab.layer.cornerRadius =5;
    _numlab.layer.borderWidth = 0.5;
    _numlab.layer.borderColor = [UIColor clearColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
