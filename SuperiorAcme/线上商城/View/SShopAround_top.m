//
//  SShopAround_top.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/2.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SShopAround_top.h"

@implementation SShopAround_top

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SShopAround_top" owner:self options:nil];
        [self addSubview:_thisView];
        
        _collectBtn.layer.masksToBounds = YES;
        _collectBtn.layer.cornerRadius = 3;
        _shareBtn.layer.masksToBounds = YES;
        _shareBtn.layer.cornerRadius = 3;
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

@end
