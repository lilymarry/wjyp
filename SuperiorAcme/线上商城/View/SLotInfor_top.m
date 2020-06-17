//
//  SLotInfor_top.m
//  SuperiorAcme
//
//  Created by GYM on 2017/8/3.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SLotInfor_top.h"

@implementation SLotInfor_top

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SLotInfor_top" owner:self options:nil];
        [self addSubview:_thisView];
        
        _songR.layer.masksToBounds = YES;
        _songR.layer.cornerRadius = _songR.frame.size.width/2;
        
        _auth_descGround.layer.masksToBounds = YES;
        _auth_descGround.layer.cornerRadius = 3;

    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

@end
