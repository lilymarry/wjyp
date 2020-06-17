//
//  SGoodsInfor_nav.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/17.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGoodsInfor_nav.h"

@implementation SGoodsInfor_nav

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SGoodsInfor_nav" owner:self options:nil];
        [self addSubview:_thisView];
        
        _oneLine.layer.masksToBounds = YES;
        _oneLine.layer.cornerRadius = 1.5;
        _twoLine.layer.masksToBounds = YES;
        _twoLine.layer.cornerRadius = 1.5;
        _threeLine.layer.masksToBounds = YES;
        _threeLine.layer.cornerRadius = 1.5;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (CGSize)intrinsicContentSize

{
    return UILayoutFittingExpandedSize;
    
}

-(void)setIsCollectOrFooter:(BOOL)isCollectOrFooter{
    _isCollectOrFooter = isCollectOrFooter;
    if (_isCollectOrFooter) {
    _twoBtnCenterConstant.constant = -self.bounds.size.width / 4.0 + 20;
    }
}


@end
