//
//  SNPageSlider.m
//  SNPageView
//
//  Created by wangsen on 16/3/30.
//  Copyright © 2016年 wangsen. All rights reserved.
//

#import "SNPageSlider.h"
#import "SNPageView.h"
@interface SNPageSlider ()
@property (nonatomic, assign) PageViewStyle pageViewStyle;
@property (nonatomic, strong) SNPageView * pageView;
@property (nonatomic, strong) UIView * lineView;
@property (nonatomic, strong) UIView * arcView;
@end
@implementation SNPageSlider
+ (instancetype)showInPageView:(SNPageView *)pageView p_style:(PageViewStyle)p_style {
    return [[self alloc] initWithFrame:CGRectMake(0, 0, pageView.titleWidth, pageView.tilteHeght) pageView:pageView  p_style:p_style];
}

- (instancetype)initWithFrame:(CGRect)frame pageView:(SNPageView *)pageView p_style:(PageViewStyle)style{
    self = [super initWithFrame:frame];
    if (self) {
        _pageViewStyle = style;
        _pageView = pageView;
        [self createSubViews];
    }
    return self;
}

- (void)createSubViews {
    switch (_pageViewStyle) {
        case PageViewStyleLine:
            [self createLine];
            break;
        case PageViewStyleArcFill:
            [self createArcFill];
            break;
        case PageViewStyleArcHollow:
            [self createArcHollow];
            break;
        case PageViewStyleSquareFill:
            [self createSquare];
            break;
        default:
            break;
    }
}

- (void)createLine {
    self.lineView.backgroundColor = [UIColor redColor];
}

- (void)createArcFill {
    self.arcView.backgroundColor = _pageView.sliderColor;
}

- (void)createArcHollow {
    self.arcView.layer.borderColor = _pageView.sliderColor.CGColor;
    self.arcView.layer.borderWidth = _pageView.sliderArcHollowBordWidth;
}

- (void)createSquare {
    self.backgroundColor = _pageView.sliderColor;
}

- (UIView *)arcView {
    if (!_arcView) {
        _arcView = [[UIView alloc] initWithFrame:CGRectMake(5, 5, self.frame.size.width - 10.f, self.frame.size.height - 10.f)];
        self.arcView.layer.cornerRadius = (self.frame.size.height - 10.f)/2;
        self.arcView.layer.masksToBounds = YES;
        [self addSubview:_arcView];
    }
    return _arcView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - _pageView.sliderLineheight, self.frame.size.width, _pageView.sliderLineheight)];
        [self addSubview:_lineView];
    }
    return _lineView;
}

@end
