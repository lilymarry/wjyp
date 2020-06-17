//
//  SGoodsInfor_down.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/19.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGoodsInfor_down.h"

@implementation SGoodsInfor_down

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SGoodsInfor_down" owner:self options:nil];
        [self addSubview:_thisView];
        

        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}


@end
