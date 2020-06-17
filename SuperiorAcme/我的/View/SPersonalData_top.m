//
//  SPersonalData_top.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/21.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SPersonalData_top.h"

@implementation SPersonalData_top

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SPersonalData_top" owner:self options:nil];
        [self addSubview:_thisView];
        
        _headerImage.layer.masksToBounds = YES;
        _headerImage.layer.cornerRadius = _headerImage.frame.size.width/2;
        _headerImage.layer.borderWidth = 0.5;
        _headerImage.layer.borderColor = [UIColor redColor].CGColor;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

@end
