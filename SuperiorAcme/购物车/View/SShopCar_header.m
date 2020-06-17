//
//  SShopCar_header.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SShopCar_header.h"

@implementation SShopCar_header

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SShopCar_header" owner:self options:nil];
        [self addSubview:_thisView];

    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
@end
