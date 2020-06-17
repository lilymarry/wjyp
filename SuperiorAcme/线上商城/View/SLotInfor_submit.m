//
//  SLotInfor_submit.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/3.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SLotInfor_submit.h"

@implementation SLotInfor_submit

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SLotInfor_submit" owner:self options:nil];
        [self addSubview:_thisView];
   
        _groundView.layer.masksToBounds = YES;
        _groundView.layer.cornerRadius = 3;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (IBAction)backBtn:(UIButton *)sender {
    if (self.SLotInfor_submit_back) {
        self.SLotInfor_submit_back();
    }
}
- (IBAction)submitBtn:(UIButton *)sender {
    if (self.SLotInfor_submit_payMoney) {
        self.SLotInfor_submit_payMoney(_payMoney_TF.text);
    }
}

@end
