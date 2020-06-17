//
//  UIView+customGetCurrentUIViewController.m
//  SuperiorAcme
//

//  Copyright © 2018年 GYM. All rights reserved.
//

#import "UIView+customGetCurrentUIViewController.h"

@implementation UIView (customGetCurrentUIViewController)

/**
 获取当前所在的视图控制器
 
 @return 当前所在的视图控制器
 */
+ (UIViewController *)getCurrentUIViewController:(UIView *)view {
    UIResponder *next = [view nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

+(UINavigationController *)getNavigationControllerWithView:(UIView *)view{
   return [UIView getCurrentUIViewController:view].navigationController;
}

@end
