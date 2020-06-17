//
//  HLDoubleSlideView.h
//  DriveUserProject
//
//  Created by sd on 16/3/16.
//  Copyright © 2016年 CJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HLDoubleSlideViewSwitchStrBock)(CGFloat count_left, CGFloat count_right);

@interface HLDoubleSlideView : UIView

@property(nonatomic,assign)CGFloat maxValue;
@property(nonatomic,assign)CGFloat minValue;
@property(nonatomic,assign)CGFloat currentLeftValue;
@property(nonatomic,assign)CGFloat currentRightValue;

//格式化显示文本
@property(nonatomic,copy)HLDoubleSlideViewSwitchStrBock block;

@end
