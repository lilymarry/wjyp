//
//  UIView+customGetCurrentUIViewController.h
//  SuperiorAcme
//

//  Copyright © 2018年 GYM. All rights reserved.
//  获取当前view所在的视图控制器

#import <UIKit/UIKit.h>

@interface UIView (customGetCurrentUIViewController)


/**
 获取当前所在的视图控制器

 @return 当前所在的视图控制器
 */
+ (UIViewController *)getCurrentUIViewController:(UIView *)view;

+(UINavigationController *)getNavigationControllerWithView:(UIView *)view;

@end
