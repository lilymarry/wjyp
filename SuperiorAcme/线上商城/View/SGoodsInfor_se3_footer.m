//
//  SGoodsInfor_se3_footer.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/19.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGoodsInfor_se3_footer.h"

@implementation SGoodsInfor_se3_footer

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SGoodsInfor_se3_footer" owner:self options:nil];
        [self addSubview:_thisView];
        
        _allEvaBtn.layer.masksToBounds = YES;
        _allEvaBtn.layer.cornerRadius = 15;
        _allEvaBtn.layer.borderWidth = 0.5;
        _allEvaBtn.layer.borderColor = [UIColor redColor].CGColor;
        
        _oneBtn.layer.masksToBounds = YES;
        _oneBtn.layer.cornerRadius = 17.5;
        _oneBtn.layer.borderWidth = 0.5;
        _oneBtn.layer.borderColor = [UIColor redColor].CGColor;
        
        _twoBtn.layer.masksToBounds = YES;
        _twoBtn.layer.cornerRadius = 17.5;
        _twoBtn.layer.borderWidth = 0.5;
        _twoBtn.layer.borderColor = [UIColor redColor].CGColor;
        
        _headerImage.layer.masksToBounds = YES;
        _headerImage.layer.cornerRadius = _headerImage.frame.size.width/2;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

@end
