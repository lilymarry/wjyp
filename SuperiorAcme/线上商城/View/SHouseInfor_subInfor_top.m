//
//  SHouseInfor_subInfor_top.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/18.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SHouseInfor_subInfor_top.h"

@implementation SHouseInfor_subInfor_top

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SHouseInfor_subInfor_top" owner:self options:nil];
        [self addSubview:_thisView];
        
        _songR.layer.masksToBounds = YES;
        _songR.layer.cornerRadius = _songR.frame.size.width/2;
        _daiR.layer.masksToBounds = YES;
        _daiR.layer.cornerRadius = 3;
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

@end
