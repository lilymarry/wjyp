//
//  SGoodsInfor_top.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/18.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGoodsInfor_top.h"

@implementation SGoodsInfor_top

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SGoodsInfor_top" owner:self options:nil];
        [self addSubview:_thisView];
        [self createUI];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (void)createUI {
    _songR.layer.masksToBounds = YES;
    _songR.layer.cornerRadius = _songR.frame.size.width/2;
    _daiR.layer.masksToBounds = YES;
    _daiR.layer.cornerRadius = 3;
    _canR.layer.masksToBounds = YES;
    _canR.layer.cornerRadius = 3;
    
    _proBlue.layer.masksToBounds = YES;
    _proBlue.layer.cornerRadius = 3;
    _proBlue.layer.borderWidth = 0.5;
    _proBlue.layer.borderColor = MyBlue.CGColor;
    
}
@end
