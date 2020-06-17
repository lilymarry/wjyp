//
//  SLotInfor_header.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/3.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SLotInfor_header.h"

@implementation SLotInfor_header

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SLotInfor_header" owner:self options:nil];
        [self addSubview:_thisView];
        
        _shopAroundBtn.layer.masksToBounds = YES;
        _shopAroundBtn.layer.cornerRadius = 3;
        _shopAroundBtn.layer.borderWidth = 1.0;
        _shopAroundBtn.layer.borderColor = MyLine.CGColor;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

@end
