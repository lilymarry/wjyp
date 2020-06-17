//
//  SAddress_Top.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/30.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SAddress_Top.h"

@implementation SAddress_Top

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SAddress_Top" owner:self options:nil];
        [self addSubview:_thisView];
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

@end
