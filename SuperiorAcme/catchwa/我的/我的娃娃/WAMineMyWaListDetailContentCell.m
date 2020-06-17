//
//  MAMineMyWaListDetailContentCell.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/8.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAMineMyWaListDetailContentCell.h"

@implementation WAMineMyWaListDetailContentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _goodChangBtn.layer.masksToBounds = YES;
    _goodChangBtn.layer.cornerRadius = 15;
    _goodChangBtn.layer.borderWidth = 0.1;
    _goodChangBtn.layer.borderColor =[UIColor clearColor].CGColor;
    
    _moneyChangBtn.layer.masksToBounds = YES;
    _moneyChangBtn.layer.cornerRadius = 15;
    _moneyChangBtn.layer.borderWidth = 0.1;
    _moneyChangBtn.layer.borderColor =[UIColor clearColor].CGColor;
    
  
    _headImaView.layer.masksToBounds = YES;
    _headImaView.layer.cornerRadius = _headImaView.frame.size.width/2;
    _headImaView.layer.borderWidth = 0.1;
    _headImaView.layer.borderColor =[UIColor clearColor].CGColor;
    
    _goodChangBtn.tag = 1;
    [_goodChangBtn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    _moneyChangBtn.tag = 2;
    [_moneyChangBtn addTarget:self action:@selector(btnEvent:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)btnEvent:(id)sender {
    UIButton * btn = (UIButton *)sender;
    NSInteger num = btn.tag;
    self.topBtnBlock(num);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
