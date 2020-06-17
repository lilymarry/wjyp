//
//  SNPageView.m
//  SNPageView
//
//  Created by wangsen on 16/3/30.
//  Copyright © 2016年 wangsen. All rights reserved.
//

#import "SNPageView.h"
@interface SNPageView () <UIScrollViewDelegate>
{
    CGRect _pageFrame;
    UIButton * _selectedButton;
    BOOL is_no;//是否滑动
}
@property (nonatomic, copy) PageViewActionBlock pageViewActionBlock;
@property (nonatomic, assign) PageViewStyle pageViewStyle;
@end
@implementation SNPageView
- (instancetype)initWithFrame:(CGRect)frame p_style:(PageViewStyle)p_style {
    self = [super initWithFrame:frame];
    if (self) {
        _pageFrame = frame;
        _pageViewStyle = p_style;
        _tilteHeght = 50.f;
        _sliderLineheight = 2.f;
        _sliderArcHollowBordWidth = 1.f;
        _topTitleViewColor = [UIColor groupTableViewBackgroundColor];
        _titleNormalColor = WordColor;
        _titleSelectedColor = [UIColor redColor];
        _sliderColor = [UIColor whiteColor];
        _titleNormalFont = [UIFont systemFontOfSize:14];
        _titleSelectedFont = [UIFont systemFontOfSize:14];
        _defaultSelectedIndex = 0;
        
        is_no = YES;//默认可以左右切换
        
        if (KIsiPhoneX) {
            frame.origin.y = 88;
            frame.size.height = frame.size.height - 23.5;
        }
        self.frame = frame;
    }
    return self;
}

- (void)showInView:(UIView *)view action:(PageViewActionBlock)action {
    _pageViewActionBlock = [action copy];
    [self startAddSubView];
    [view addSubview:self];
}

- (void)startAddSubView {
    NSInteger subCount = _subViews.count;
    NSInteger titleCount = _titles.count;
    NSInteger count = titleCount > subCount?subCount:titleCount;
    [self.topScrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self.containerScrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    _pageSliderView = [SNPageSlider showInPageView:self p_style:_pageViewStyle];
    [self.topScrollView addSubview:_pageSliderView];
    for (NSInteger i = 0; i < count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = _goundNormalColor;
        btn.titleLabel.numberOfLines = 0;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.frame = CGRectMake(_titleWidth * i, 0, _titleWidth, _tilteHeght - 3);
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        [btn setTitleColor:_titleNormalColor forState:UIControlStateNormal];
        [btn setTitleColor:_titleSelectedColor forState:UIControlStateSelected];
        btn.titleLabel.font = _titleNormalFont;
        btn.tag = i + kBtnTag(_customTag);
        [btn addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.topScrollView addSubview:btn];
        
        id obj = _subViews[i];
        if ([obj isKindOfClass:[NSString class]]) {
            obj = NSClassFromString(obj);
        }
        id subView = [[obj alloc] initWithFrame:CGRectMake(_pageFrame.size.width * i, 0, _pageFrame.size.width, _pageFrame.size.height - _tilteHeght)];
        [subView setTag:kSubViewTag(_customTag) + i];
        [self.containerScrollView addSubview:subView];
        
        if (i == _defaultSelectedIndex) {
            [self titleButtonClick:btn];
        }

    }
    self.topScrollView.contentSize = CGSizeMake(count * _titleWidth, _tilteHeght);
    self.containerScrollView.contentSize = CGSizeMake(count * _pageFrame.size.width, _pageFrame.size.height - _tilteHeght);
    self.topScrollView.backgroundColor = _topTitleViewColor;
}

- (void)titleButtonClick:(UIButton *)btn {
    _selectedButton.selected = NO;
    _selectedButton.titleLabel.font = _titleNormalFont;
    btn.selected = YES;
    btn.titleLabel.font = _titleSelectedFont;
    _selectedButton = btn;
    [self sliderAnimation];
    [_topScrollView scrollRectToVisible:btn.frame animated:YES];
    [_containerScrollView setContentOffset:CGPointMake(_pageFrame.size.width *(btn.tag - kBtnTag(_customTag)),0) animated:YES];
    if (self.pageViewActionBlock) {
        self.pageViewActionBlock([_containerScrollView viewWithTag:kSubViewTag(_customTag) + (_selectedButton.tag - kBtnTag(_customTag))],_selectedButton,_selectedButton.tag - kBtnTag(_customTag));
    }
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _containerScrollView) {
        NSInteger offSetCount = scrollView.contentOffset.x/_pageFrame.size.width;
        UIButton * btn = [_topScrollView viewWithTag:offSetCount + kBtnTag(_customTag)];
        
        if (btn.tag != _selectedButton.tag) {
            [self.topScrollView scrollRectToVisible:btn.frame animated:YES];
            _selectedButton.selected = NO;
            _selectedButton.titleLabel.font = _titleNormalFont;
            btn.selected = YES;
            btn.titleLabel.font = _titleSelectedFont;
            _selectedButton = btn;
            [self sliderAnimation];
            if (self.pageViewActionBlock) {
                self.pageViewActionBlock([_containerScrollView viewWithTag:kSubViewTag(_customTag) + (_selectedButton.tag - kBtnTag(_customTag))],_selectedButton,_selectedButton.tag - kBtnTag(_customTag));
            }
        }
    }
}

- (void)sliderAnimation {
    CGRect sliderViewFrame = _pageSliderView.frame;
    sliderViewFrame.origin.x = _selectedButton.frame.origin.x;
//    [UIView animateWithDuration:0.28 animations:^{
        _pageSliderView.frame = sliderViewFrame;
//    }];
}

#pragma mark - scrollView
- (UIScrollView *)topScrollView {
    if (!_topScrollView) {
        _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _pageFrame.size.width, _tilteHeght)];
        _topScrollView.bounces = NO;
        _topScrollView.showsHorizontalScrollIndicator = NO;
        _topScrollView.showsVerticalScrollIndicator = NO;
        _topScrollView.delegate = self;
        [self addSubview:_topScrollView];
    }
    return _topScrollView;
}

- (UIScrollView *)containerScrollView {
    if (!_containerScrollView) {
        _containerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _tilteHeght, _pageFrame.size.width, _pageFrame.size.height - _tilteHeght)];
        _containerScrollView.pagingEnabled = YES;
        _containerScrollView.bounces = NO;
        _containerScrollView.showsHorizontalScrollIndicator = NO;
        _containerScrollView.showsVerticalScrollIndicator = NO;
        _containerScrollView.delegate = self;
        [self addSubview:_containerScrollView];
    }
    return _containerScrollView;
}

@end
