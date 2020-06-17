//
//  SLineShop_infor_rightTop.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SLineShop_infor_rightTop.h"

@implementation SLineShop_infor_rightTop

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SLineShop_infor_rightTop" owner:self options:nil];
        [self addSubview:_thisView];

        _topDiscountView.layer.masksToBounds = YES;
        _topDiscountView.layer.cornerRadius = 3;
        _topDiscountView.layer.borderWidth = 1.0;
        _topDiscountView.layer.borderColor = MyLine.CGColor;
        
        _topDiscount_R.layer.masksToBounds = YES;
        _topDiscount_R.layer.cornerRadius = 12.5;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

@end
