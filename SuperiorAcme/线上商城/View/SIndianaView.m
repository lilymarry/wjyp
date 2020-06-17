//
//  SIndianaView.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/17.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SIndianaView.h"
#import "CBAutoScrollLabel.h"

@implementation SIndianaView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SIndianaView" owner:self options:nil];
        [self addSubview:_thisView];
        
//        CBAutoScrollLabel * autoScrollLabel = [[CBAutoScrollLabel alloc] initWithFrame:_autoLabel.bounds];
//        autoScrollLabel.text = @"恭喜恭喜恭喜恭喜恭喜恭喜恭喜恭喜恭喜恭喜恭喜恭喜恭喜恭喜恭喜恭喜恭喜恭喜恭喜恭喜";
//        autoScrollLabel.font = [UIFont systemFontOfSize:14];
//        autoScrollLabel.textColor = WordColor;
//        autoScrollLabel.labelSpacing = 30; // distance between start and end labels
//        autoScrollLabel.pauseInterval = 1.7; // seconds of pause before scrolling starts again
//        autoScrollLabel.scrollSpeed = 30; // pixels per second
//        autoScrollLabel.textAlignment = NSTextAlignmentLeft; // centers text when no auto-scrolling is applied
//        autoScrollLabel.fadeLength = 12.f;
//        autoScrollLabel.scrollDirection = CBAutoScrollDirectionLeft;
//        [autoScrollLabel observeApplicationNotifications];
//        [_autoLabel addSubview:autoScrollLabel];
        
//        UIButton * locationBtn = [[UIButton alloc] initWithFrame:this_newNav.address_subView.bounds];
//        //    [locationBtn setTitle:@"上海市浦东新区世纪大道100号" forState:UIControlStateNormal];
//        locationBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        [locationBtn setTitleColor:wordGayColor forState:UIControlStateNormal];
//        locationBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//        [this_newNav.address_subView addSubview:locationBtn];
        
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}

@end
