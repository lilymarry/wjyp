//
//  SNPageView.h
//  SNPageView
//
//  Created by wangsen on 16/3/30.
//  Copyright © 2016年 wangsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNPageConst.h"
#import "SNPageSlider.h"

typedef void(^PageViewActionBlock)(id subView,UIButton * btn, NSInteger index);

@interface SNPageView : UIView

- (instancetype)initWithFrame:(CGRect)frame p_style:(PageViewStyle)p_style;
/**
 *
 *  顶部滚动视图颜色
 */
@property (nonatomic, strong) UIColor * topTitleViewColor;
/**
 *
 *  顶部按钮高度
 */
@property (nonatomic, assign) CGFloat tilteHeght;
/**
 *
 *  顶部按钮宽度
 */
@property (nonatomic, assign) CGFloat titleWidth;
/**
 *
 *  顶部按钮标题
 */
@property (nonatomic, strong) NSArray * titles;
/**
 *
 *  按钮normal颜色
 */
@property (nonatomic, strong) UIColor * titleNormalColor;
/**
 *
 *  按钮选中背景颜色
 */
@property (nonatomic, strong) UIColor * goundNormalColor;
/**
 *
 *  按钮选中颜色
 */
@property (nonatomic, strong) UIColor * titleSelectedColor;
/**
 *
 *  按钮normal字体大小
 */
@property (nonatomic, strong) UIFont * titleNormalFont;
/**
 *
 *  按钮选中字体大小
 */
@property (nonatomic, strong) UIFont * titleSelectedFont;
/**
 *
 *  可切换子视图
 */
@property (nonatomic, strong) NSArray * subViews;
/**
 *
 *  滑块颜色
 */
@property (nonatomic, strong) UIColor * sliderColor;
/**
 *
 *  line滑块高度 style为line时设置
 */
@property (nonatomic, assign) CGFloat sliderLineheight;
/**
 *
 *  弧形空心 style为Hollow边框宽度
 */
@property (nonatomic, assign) CGFloat sliderArcHollowBordWidth;
/*
 * 默认选中
 */
@property (nonatomic, assign) NSInteger defaultSelectedIndex;
/**
 *
 *  显示到视图上
 *
 *  @param view
 */
- (void)showInView:(UIView *)view action:(PageViewActionBlock)action;

/*
 供外部刷新视图使用
 */
- (void)titleButtonClick:(UIButton *)btn;


//是否可以滑动
@property (nonatomic, strong) UIScrollView * containerScrollView;
@property (nonatomic, strong) UIScrollView * topScrollView;
@property (nonatomic, strong) SNPageSlider * pageSliderView;

@property (nonatomic, assign) NSInteger customTag;
@end
