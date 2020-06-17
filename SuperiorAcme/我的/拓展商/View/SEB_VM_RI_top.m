//
//  SEB_VM_RI_top.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/20.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SEB_VM_RI_top.h"

@implementation SEB_VM_RI_top

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SEB_VM_RI_top" owner:self options:nil];
        [self addSubview:_thisView];
        
        _headerImage.layer.masksToBounds = YES;
        _headerImage.layer.cornerRadius = 20;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

@end
