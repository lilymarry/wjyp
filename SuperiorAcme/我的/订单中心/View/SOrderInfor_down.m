//
//  SOrderInfor_down.m
//  SuperiorAcme
//
//  Created by GYM on 2018/2/11.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SOrderInfor_down.h"

@implementation SOrderInfor_down

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SOrderInfor_down" owner:self options:nil];
        [self addSubview:_thisView];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

@end
