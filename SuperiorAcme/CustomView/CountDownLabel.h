//
//  CountDownLabel.h
//  CustomUI
//
//  Created by 科技沃天 on 2018/5/15.
//  Copyright © 2018年 科技沃天. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountDownLabel : UILabel

/**
 时间的背景框的颜色
 */
@property (nonatomic, strong) UIColor * TextBackGroundColor;

/**
 背景框的圆角
 */
@property (nonatomic, assign) CGFloat TextBackGroundCornerRadius;

/**
 文字的颜色
 */
@property (nonatomic, strong) UIColor * TextColor;

/**
 显示的时间的颜色
 */
@property (nonatomic, strong) UIColor * DateColor;

@end
