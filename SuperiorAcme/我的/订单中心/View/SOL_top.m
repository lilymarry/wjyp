//
//  SOL_top.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/18.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SOL_top.h"

@implementation SOL_top

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SOL_top" owner:self options:nil];
        [self addSubview:_thisView];
        
        _thisR.layer.masksToBounds = YES;
        _thisR.layer.cornerRadius = 15;
        _thisR.layer.borderWidth = 0.5;
        _thisR.layer.borderColor = [UIColor redColor].CGColor;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

@end
