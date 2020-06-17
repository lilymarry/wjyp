//
//  SLineShop_header.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SLineShop_header.h"

@implementation SLineShop_header

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SLineShop_header" owner:self options:nil];
        [self addSubview:_thisView];
        
        _headerImage.layer.masksToBounds = YES;
        _headerImage.layer.cornerRadius = 3;
        
        _thisTitle_sub.layer.masksToBounds = YES;
        _thisTitle_sub.layer.cornerRadius = 3;
        _thisTitle_sub.layer.borderWidth = 1.0;
        _thisTitle_sub.layer.borderColor = MyBlue.CGColor;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (IBAction)selectBtn:(UIButton *)sender {
    if (self.SLineShop_header_selectBtn) {
        self.SLineShop_header_selectBtn();
    }
}

@end
