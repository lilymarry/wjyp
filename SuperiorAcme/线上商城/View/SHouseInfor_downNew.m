//
//  SHouseInfor_downNew.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/19.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SHouseInfor_downNew.h"

@implementation SHouseInfor_downNew

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SHouseInfor_downNew" owner:self options:nil];
        [self addSubview:_thisView];
        
        _scroll_evaMoreBtn.layer.masksToBounds = YES;
        _scroll_evaMoreBtn.layer.cornerRadius = 3;
        _scroll_evaMoreBtn.layer.borderWidth = 1.0;
        _scroll_evaMoreBtn.layer.borderColor = MyLine.CGColor;
        
        _head_pic.layer.masksToBounds = YES;
        _head_pic.layer.cornerRadius = _head_pic.frame.size.width/2;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}


@end
