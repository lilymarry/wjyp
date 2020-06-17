//
//  SHouseInfor_topNew.m
//  SuperiorAcme
//
//  Created by GYM on 2017/9/19.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SHouseInfor_topNew.h"

@implementation SHouseInfor_topNew

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SHouseInfor_topNew" owner:self options:nil];
        [self addSubview:_thisView];

    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

@end
