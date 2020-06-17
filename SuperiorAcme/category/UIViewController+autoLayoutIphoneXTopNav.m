//
//  UIViewController+autoLayoutIphoneXTopNav.m
//  SuperiorAcme
//

//  Copyright © 2018年 GYM. All rights reserved.
//

#import "UIViewController+autoLayoutIphoneXTopNav.h"
#import <objc/message.h>

@implementation UIViewController (autoLayoutIphoneXTopNav)

+ (void)load {
    //方法交换应该被保证，在程序中只会执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //获得viewController的生命周期方法的selector
        SEL systemSel = @selector(viewWillAppear:);
        //自己实现的将要被交换的方法的selector
        SEL swizzSel = @selector(myViewWillAppear:);
        //两个方法的Method
        Method systemMethod = class_getInstanceMethod([self class], systemSel);
        Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
        //首先动态添加方法，实现是被交换的方法，返回值表示添加成功还是失败
        BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
        if (isAdd) {
            //如果成功，说明类中不存在这个方法的实现
            //将被交换方法的实现替换到这个并不存在的实现
            class_replaceMethod(self, swizzSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
        } else {
            //否则，交换两个方法的实现
            method_exchangeImplementations(systemMethod, swizzMethod);
        }
    });
}
- (void)myViewWillAppear:(BOOL)animated {
    [self myViewWillAppear:YES];
    if (KIsiPhoneX) {
        //此机型是iphoneX
        for (int i = 0; i < self.view.constraints.count; i++) {
            if (self.view.constraints[i].constant == 64 || self.view.constraints[i].constant == 64.5) {
                //调整顶部
                self.view.constraints[i].constant = 88;
            }
            if (self.view.constraints[i].constant == 49) {
                //调整底部
                self.view.constraints[i].constant = 83;
            }
        }
    }
}

@end
