//
//  SAM_MS_Nav.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/19.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SAM_MS_Nav.h"

@implementation SAM_MS_Nav

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SAM_MS_Nav" owner:self options:nil];
        [self addSubview:_thisView];
        _groundView.layer.masksToBounds = YES;
        _groundView.layer.cornerRadius = 2;
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
