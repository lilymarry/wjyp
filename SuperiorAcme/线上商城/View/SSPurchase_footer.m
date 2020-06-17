//
//  SSPurchase_footer.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SSPurchase_footer.h"

@implementation SSPurchase_footer

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SSPurchase_footer" owner:self options:nil];
        [self addSubview:_thisView];
        
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 5;
        
        _groundView.layer.masksToBounds = YES;
        _groundView.layer.cornerRadius = 5;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}


@end
