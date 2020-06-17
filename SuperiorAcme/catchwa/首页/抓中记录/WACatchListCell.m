//
//  WACatchListCell.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/10.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WACatchListCell.h"

@implementation WACatchListCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    _view_back.layer.masksToBounds = YES;
//    _view_back.layer.cornerRadius = 15;
//    _view_back.layer.borderWidth = 0.3;
//    _view_back.layer.borderColor =[UIColor lightGrayColor].CGColor;
    
    _headImaview.layer.masksToBounds = YES;
    _headImaview.layer.cornerRadius = _headImaview.frame.size.width/2;
    _headImaview.layer.borderWidth = 0.1;
    _headImaview.layer.borderColor =[UIColor clearColor].CGColor;
    
//    _oneBtn.tag = 1;
//    [_oneBtn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
//
//    _twoBtn.tag = 2;
//    [_twoBtn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//- (void)btnEvent:(id)sender {
//    UIButton * btn = (UIButton *)sender;
//    NSInteger num = btn.tag;
//    self.topBtnBlock(num);
//}
@end
