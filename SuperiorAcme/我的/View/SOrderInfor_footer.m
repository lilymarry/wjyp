//
//  SOrderInfor_footer.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOrderInfor_footer.h"

@implementation SOrderInfor_footer

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SOrderInfor_footer" owner:self options:nil];
        [self addSubview:_thisView];

    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

@end
