//
//  SMember_top.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/21.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SMember_top.h"

@implementation SMember_top

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SMember_top" owner:self options:nil];
        [self addSubview:_thisView];

        _headerImage.layer.masksToBounds = YES;
        _headerImage.layer.cornerRadius = _headerImage.frame.size.width/2;
        _headerImage.layer.borderWidth = 0.5;
        _headerImage.layer.borderColor = [UIColor whiteColor].CGColor;
        
        _memberR.layer.masksToBounds = YES;
        _memberR.layer.cornerRadius = 12.5;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

@end
