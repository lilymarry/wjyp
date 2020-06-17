//
//  SNPageSlider.h
//  SNPageView
//
//  Created by wangsen on 16/3/30.
//  Copyright © 2016年 wangsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SNPageConst.h"
@class SNPageView;
@interface SNPageSlider : UIView
+ (instancetype)showInPageView:(SNPageView *)pageView p_style:(PageViewStyle)p_style;
@end
