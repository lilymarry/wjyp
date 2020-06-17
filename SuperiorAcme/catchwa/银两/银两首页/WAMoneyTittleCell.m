//
//  WAMoneyTittleCell.m
//  CatchWAWA
//
//  Created by donkey on 2019/1/5.
//  Copyright © 2019 wotianshiyan. All rights reserved.
//

#import "WAMoneyTittleCell.h"

@implementation WAMoneyTittleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _imaV_back.layer.masksToBounds = YES;
    _imaV_back.layer.cornerRadius = 15;
    _imaV_back.layer.borderWidth = 5;
    _imaV_back.layer.borderColor =[UIColor clearColor].CGColor;
    // Initialization code
    
    _moneyBtn.layer.masksToBounds = YES;
    _moneyBtn.layer.cornerRadius = 15;
    _moneyBtn.layer.borderWidth = 1;
    _moneyBtn.layer.borderColor =[UIColor whiteColor].CGColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)moneyListPress:(id)sender {
    if (self.wAMoneyTittleCellBtnBlock) {
        self.wAMoneyTittleCellBtnBlock();
    }
}

@end
