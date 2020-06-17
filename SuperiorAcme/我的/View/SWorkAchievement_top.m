//
//  SWorkAchievement_top.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/26.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SWorkAchievement_top.h"

@implementation SWorkAchievement_top

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SWorkAchievement_top" owner:self options:nil];
        [self addSubview:_thisView];
        _thisImage.layer.masksToBounds = YES;
        _thisImage.layer.cornerRadius = 35;
        _thisImage.layer.borderWidth = 0.5;
        _thisImage.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

@end
