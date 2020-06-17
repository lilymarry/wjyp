//
//  SSearch_nav.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/14.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SSearch_nav.h"
#import <Masonry.h>

@implementation SSearch_nav

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SSearch_nav" owner:self options:nil];
        [self addSubview:_thisView];

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

-(void)setIsHiddenBtnImgV:(BOOL)isHiddenBtnImgV{
    _isHiddenBtnImgV = isHiddenBtnImgV;

    if (_isHiddenBtnImgV) {
        self.arrowImgV.hidden = YES;
        self.choiceTypeBtn.hidden = YES;
        [_searchTF mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.bottom.top.right.mas_equalTo(0);
        }];
    }
    
}

@end
