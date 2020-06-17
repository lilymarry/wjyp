//
//  SEB_VoucherAuditView_down.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/17.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SEB_VoucherAuditView_down.h"

@implementation SEB_VoucherAuditView_down

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SEB_VoucherAuditView_down" owner:self options:nil];
        [self addSubview:_thisView];
        
        _oneBtn.layer.borderWidth = 0.5;
        _oneBtn.layer.borderColor = WordColor_sub.CGColor;
        _oneBtn.layer.masksToBounds = YES;
        _oneBtn.layer.cornerRadius = 3;
        _twoBtn.layer.masksToBounds = YES;
        _twoBtn.layer.cornerRadius = 3;
        
        _statusContent.hidden = YES;
        _oneBtn.hidden = YES;
        _twoBtn.hidden = YES;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

@end
