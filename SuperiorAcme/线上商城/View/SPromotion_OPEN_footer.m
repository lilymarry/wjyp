//
//  SPromotion_OPEN_footer.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/22.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SPromotion_OPEN_footer.h"

@implementation SPromotion_OPEN_footer

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SPromotion_OPEN_footer" owner:self options:nil];
        [self addSubview:_thisView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

@end
