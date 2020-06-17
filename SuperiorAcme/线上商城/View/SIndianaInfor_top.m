//
//  SIndianaInfor_top.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/4.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SIndianaInfor_top.h"

@implementation SIndianaInfor_top

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SIndianaInfor_top" owner:self options:nil];
        [self addSubview:_thisView];
        
        _showTitle.layer.masksToBounds = YES;
        _showTitle.layer.cornerRadius = 3;
        _showTitle.layer.borderWidth = 1.0;
        _showTitle.layer.borderColor = MyGreen.CGColor;
        
        _songR.layer.masksToBounds = YES;
        _songR.layer.cornerRadius = _songR.frame.size.width/2;
        
        _thisRedPro.layer.masksToBounds = YES;
        _thisRedPro.layer.cornerRadius = 5;

    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

@end
