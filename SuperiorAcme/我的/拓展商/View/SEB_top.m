//
//  SEB_top.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/16.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SEB_top.h"

@implementation SEB_top

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SEB_top" owner:self options:nil];
        [self addSubview:_thisView];
        _headerImage.layer.masksToBounds = YES;
        _headerImage.layer.cornerRadius = _headerImage.frame.size.width/2;
        _headerImage.layer.borderWidth = 0.5;
        _headerImage.layer.borderColor = [UIColor whiteColor].CGColor;

        _upBtn.layer.masksToBounds = YES;
        _upBtn.layer.cornerRadius = 12.5;
        _upBtn.hidden = YES;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
@end
