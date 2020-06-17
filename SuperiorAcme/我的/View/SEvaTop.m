//
//  SEvaTop.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/26.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SEvaTop.h"

@implementation SEvaTop

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SEvaTop" owner:self options:nil];
        [self addSubview:_thsiView];
        _num.layer.masksToBounds = YES;
        _num.layer.cornerRadius = 17.5;

    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thsiView.frame = self.bounds;
}

@end
