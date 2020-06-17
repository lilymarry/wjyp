//
//  SDA_Next_top.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/19.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SDA_Next_top.h"

@implementation SDA_Next_top

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SDA_Next_top" owner:self options:nil];
        [self addSubview:_thisView];
        
        _thisR.layer.masksToBounds = YES;
        _thisR.layer.cornerRadius = 2;
        _thisRBtn.layer.masksToBounds = YES;
        _thisRBtn.layer.cornerRadius = 2;
        _thisRBtn.layer.borderWidth = 0.5;
        _thisRBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        _headerImage.layer.masksToBounds = YES;
        _headerImage.layer.cornerRadius = 25;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

@end
