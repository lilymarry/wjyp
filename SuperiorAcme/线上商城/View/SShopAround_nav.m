//
//  SShopAround_nav.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/2.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SShopAround_nav.h"

@implementation SShopAround_nav


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SShopAround_nav" owner:self options:nil];
        [self addSubview:_thisView];
        
        
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (CGSize)intrinsicContentSize
{
    return UILayoutFittingExpandedSize;
    
}
@end
