//
//  WAMineGameListCell.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/9.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAMineGameListCell.h"

@implementation WAMineGameListCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    _view_back.layer.masksToBounds = YES;
//    _view_back.layer.cornerRadius = 15;
//    _view_back.layer.borderWidth = 0.1;
//    _view_back.layer.borderColor =[UIColor lightGrayColor].CGColor;
    
    _headImaView.layer.masksToBounds = YES;
    _headImaView.layer.cornerRadius = _headImaView.frame.size.width/2;
    _headImaView.layer.borderWidth = 0.1;
    _headImaView.layer.borderColor =[UIColor clearColor].CGColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
