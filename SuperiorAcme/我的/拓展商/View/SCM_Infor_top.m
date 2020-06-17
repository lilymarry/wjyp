//
//  SCM_Infor_top.m
//  SuperiorAcme
//
//  Created by GYM on 2018/1/17.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SCM_Infor_top.h"

@implementation SCM_Infor_top

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SCM_Infor_top" owner:self options:nil];
        [self addSubview:_thisView];
        
        _thisTime.layer.masksToBounds = YES;
        _thisTime.layer.cornerRadius = 3;
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
@end
