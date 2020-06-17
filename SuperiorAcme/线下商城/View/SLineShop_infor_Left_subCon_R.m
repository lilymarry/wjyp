//
//  SLineShop_infor_Left_subCon_R.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SLineShop_infor_Left_subCon_R.h"
#import "SMerchantMerIndex.h"

@implementation SLineShop_infor_Left_subCon_R

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SLineShop_infor_Left_subCon_R" owner:self options:nil];
        [self addSubview:_thisView];
        
        _topDiscountView.layer.masksToBounds = YES;
        _topDiscountView.layer.cornerRadius = 3;
        _topDiscountView.layer.borderWidth = 1.0;
        _topDiscountView.layer.borderColor = MyLine.CGColor;
        
        _topDiscount_R.layer.masksToBounds = YES;
        _topDiscount_R.layer.cornerRadius = 12.5;
        
        [_couponBtn addTarget:self action:@selector(couponBtnClick) forControlEvents:UIControlEventTouchUpInside];
   
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (void)couponBtnClick {
    if (self.SLineShop_infor_Left_subCon_R_show) {
        self.SLineShop_infor_Left_subCon_R_show();
    }
}
@end
