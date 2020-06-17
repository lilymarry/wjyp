//
//  SCarefreeMember_top.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/17.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SCarefreeMember_top.h"

@implementation SCarefreeMember_top

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SCarefreeMember_top" owner:self options:nil];
        [self addSubview:_thisView];
        
        _submitBtnView.layer.masksToBounds = YES;
        _submitBtnView.layer.cornerRadius = 3;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

@end
