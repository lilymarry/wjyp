//
//  SMA_infor_top.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/20.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SMA_infor_top.h"

@implementation SMA_infor_top

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SMA_infor_top" owner:self options:nil];
        [self addSubview:_thisView];
        
        _oneBtn.layer.borderWidth = 0.5;
        _oneBtn.layer.borderColor = WordColor_sub.CGColor;
        _oneBtn.layer.masksToBounds = YES;
        _oneBtn.layer.cornerRadius = 3;
        _twoBtn.layer.masksToBounds = YES;
        _twoBtn.layer.cornerRadius = 3;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}


@end
