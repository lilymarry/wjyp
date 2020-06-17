//
//  SCarShopTop.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/17.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SCarShopTop.h"
#import "HLDoubleSlideView.h"
#import "SCarShopTopCell.h"

@interface SCarShopTop ()
{
    NSArray * thisArr;
}
@end

@implementation SCarShopTop

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SCarShopTop" owner:self options:nil];
        [self addSubview:_thisView];
        
        _sliderView.layer.masksToBounds = YES;
        _sliderView.layer.cornerRadius = 15;
        
        //价格区间
        HLDoubleSlideView *doubleSlideView = [[HLDoubleSlideView alloc] init];
        doubleSlideView.backgroundColor = [UIColor clearColor];//HLColor(244, 244, 244);
        doubleSlideView.minValue = 0;
        doubleSlideView.maxValue = 150;
        doubleSlideView.frame = CGRectMake(16, 0, ScreenW - 30 - 2, 150);
        doubleSlideView.currentLeftValue = 10;
        doubleSlideView.currentRightValue = 80;
        doubleSlideView.block = ^(CGFloat count_left, CGFloat count_right) {
            NSLog(@"count_left:%.0f",count_left);
            NSLog(@"count_right:%.0f",count_right);
            _thisPriceRange.text = [NSString stringWithFormat:@"%.0f-%.0f万",count_left,count_right];
            if (self.SCarShopTop_choice) {
                self.SCarShopTop_choice([NSString stringWithFormat:@"%.0f",count_left],[NSString stringWithFormat:@"%.0f",count_right]);
            }
        };
        [_sliderView addSubview:doubleSlideView];
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
@end
