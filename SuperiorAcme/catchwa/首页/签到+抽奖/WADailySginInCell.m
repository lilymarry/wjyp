//
//  WADailySginInCell.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/19.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WADailySginInCell.h"

@interface WADailySginInCell ()

@end

@implementation WADailySginInCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"WADailySginInCell" owner:self options:nil];
        [self addSubview:_thisView];
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}


@end
