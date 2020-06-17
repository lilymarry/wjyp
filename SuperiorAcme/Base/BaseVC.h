//
//  BaseVC.h
//  SuperiorAcme
//
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseVC : UIViewController
{
    UISegmentedControl *_segmentControl;
    UIView *flagView;
    
}

/**
 创建带分段控制器的NavigationController
 
 @param segmentedControlTitles 分段控制器 标题集合
 @param isHave 是否有右边按钮
 @param rightBtnOption 右边按钮参数字典
 */
-(void)CreatNavBar:( NSArray * _Nonnull )segmentedControlTitles andIsHaveRightBtn:(BOOL)isHave andRightBtnOption:( NSDictionary * _Nullable )rightBtnOption andDefaultHiddenForRightBtn:(BOOL)RightBtnIsHidden;
/**
 UISegmentedControl的方法
 
 @param sender UISegmentedControl被点击
 */
- (void)selectItem:(UISegmentedControl *)sender;

/**
 navRightBtn的方法
 
 @param btn 点击的按钮
 */
-(void)navRightBtn:(UIButton *)btn;

@end
