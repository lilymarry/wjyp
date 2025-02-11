//
//  SNTabBarItem.m
//  SNTabBarVC
//
//  Created by wangsen on 16/3/26.
//  Copyright © 2016年 wangsen. All rights reserved.
//

#import "SNTabBarItem.h"
#import "SNTabBarConst.h"
#import "UIView+sn_Extension.h"
@interface SNTabBarItem ()
@property (nonatomic, strong) UIButton * badgeValueItem;

@end
@implementation SNTabBarItem

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.badgeValueItem.backgroundColor = kBadeyValueBgColor;
        self.badgeValueItem.frame = CGRectMake(0,0, 15, 15);
        self.badgeValueItem.layer.cornerRadius = self.badgeValueItem.frame.size.width/2;
        self.badgeValueItem.layer.masksToBounds = YES;
        self.badgeValueItem.titleLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.badgeValueItem];
//        [self.badgeValueItem addTarget:self action:@selector(move:withEvent:) forControlEvents:UIControlEventTouchDragInside];
    }
    return self;
}

//- (void)move:(UIButton *)item withEvent:(UIEvent *)event {
//    NSLog(@"%@",[event allTouches]);
//}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    CGRect badgeFrame = self.badgeValueItem.frame;
    if (ScreenW > 375) {
        badgeFrame.origin.x = frame.size.width - 40;
    } else if (ScreenW == 375) {
        badgeFrame.origin.x = frame.size.width - 35;
    } else if (ScreenW < 375) {
        badgeFrame.origin.x = frame.size.width - 30;
    }
    badgeFrame.origin.y = 3.f;
    self.badgeValueItem.frame = badgeFrame;
}

- (void)setHighlighted:(BOOL)highlighted {
    
}

- (void)setTabBarItem:(UITabBarItem *)tabBarItem {
    _tabBarItem = tabBarItem;
    [tabBarItem addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
//    self.badgeValueItem.hidden = YES;
//    self.badgeValueItem.hidden = ![self.tabBarItem.badgeValue boolValue];
    if (self.tabBarItem.badgeValue.integerValue != 0) {
        self.badgeValueItem.hidden = NO;
    } else {
        self.badgeValueItem.hidden = YES;
    }
    if ([self.tabBarItem.badgeValue integerValue]) {
        [self.badgeValueItem setTitle:self.tabBarItem.badgeValue forState:UIControlStateNormal];
        if (self.tabBarItem.badgeValue.length == 1) {
            CGRect badgeFrame = self.badgeValueItem.frame;
            badgeFrame.size.width = 15;
            //            badgeFrame.size.height = 15;
            self.badgeValueItem.frame = badgeFrame;
            NSLog(@"self.tabBarItem.badgeValue:1_%@",self.tabBarItem.badgeValue);
        }else if (self.tabBarItem.badgeValue.length == 2) {
            CGRect badgeFrame = self.badgeValueItem.frame;
            badgeFrame.size.width = 20.f;
            //            badgeFrame.size.height = 20.f;
            self.badgeValueItem.frame = badgeFrame;
            NSLog(@"self.tabBarItem.badgeValue:2_%@",self.tabBarItem.badgeValue);
        } else if (self.tabBarItem.badgeValue.length >= 3) {
            CGRect badgeFrame = self.badgeValueItem.frame;
            badgeFrame.size.width = 25.f;
            //            badgeFrame.size.height = 25.f;
            self.badgeValueItem.frame = badgeFrame;
            NSLog(@"self.tabBarItem.badgeValue:3_%@",self.tabBarItem.badgeValue);
            //            [self.badgeValueItem setTitle:@"99+" forState:UIControlStateNormal];
        }
    }
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleX = 0.f;
    CGFloat titleY = contentRect.size.height * _itemImageScale;
    CGFloat titleWeight = contentRect.size.width;
    CGFloat titleHeight = contentRect.size.height * (1 - _itemImageScale);
    return CGRectMake(titleX, titleY, titleWeight, titleHeight);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat imageX = 0.f;
    CGFloat imageY = 5.f;
    CGFloat imageWeight = contentRect.size.width;
    CGFloat imageHeight = contentRect.size.height * _itemImageScale - 5;
    return CGRectMake(imageX, imageY, imageWeight, imageHeight);
}

- (UIButton *)badgeValueItem {
    if (!_badgeValueItem) {
        _badgeValueItem = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _badgeValueItem;
}

- (void)dealloc {
    [_tabBarItem removeObserver:self forKeyPath:@"badgeValue"];
}

@end
