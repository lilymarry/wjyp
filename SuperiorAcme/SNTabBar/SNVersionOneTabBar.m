//
//  SNVersionOneTabBar.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/5/8.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "SNVersionOneTabBar.h"

@implementation SNVersionOneTabBar

#pragma mark - 系统回调

//隐藏并删除掉系统自带的UITabBarButton
-(void)layoutSubviews{
    [super layoutSubviews];
    //隐藏掉系统自带的TabBarItem
    [self HiddenSystemTabBarItem];//因为页面跳转后,当返回时,都会重新加载系统自带的TabBar(原因不明,怀疑是因为跳转到二级页面的时候,隐藏掉了TabBar,当页面返回时,又重新加载了底部的TabBar)
}

#pragma mark - 隐藏并删除掉系统自带的TabBarItem
-(void)HiddenSystemTabBarItem{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            view.hidden = YES;
            [view removeFromSuperview];
        }
    }
}

@end
