//
//  SOrderConfirm_footer.m
//  SuperiorAcme
//
//  Created by GYM on 2018/2/8.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SOrderConfirm_footer.h"

@implementation SOrderConfirm_footer

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SOrderConfirm_footer" owner:self options:nil];
        [self addSubview:_thisView];
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

@end
