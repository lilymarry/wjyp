//
//  SOrderCenter_listView_footer.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOrderCenter_listView_footer.h"

@implementation SOrderCenter_listView_footer

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SOrderCenter_listView_footer" owner:self options:nil];
        [self addSubview:_thisView];
        
        _oneBtn.layer.masksToBounds = YES;
        _oneBtn.layer.cornerRadius = 15;
        _oneBtn.layer.borderWidth = 1.0;
        _oneBtn.layer.borderColor = MyLine.CGColor;
        
        _twoBtn.layer.masksToBounds = YES;
        _twoBtn.layer.cornerRadius = 15;
        _twoBtn.layer.borderWidth = 1.0;
        _twoBtn.layer.borderColor = [UIColor redColor].CGColor;
        
        _thisPro.layer.masksToBounds = YES;
        _thisPro.layer.cornerRadius = 3;
        _thisPro.layer.borderWidth = 1.0;
        _thisPro.layer.borderColor = MyBlue.CGColor;
        
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

@end
