//
//  CustomLayoutConstraint.m
//  SuperiorAcme
//

//  Copyright © 2018年 GYM. All rights reserved.
//

#import "CustomLayoutConstraint.h"

@implementation CustomLayoutConstraint

/**
 针对iphoneX距离顶部做适配
 */
+ (void)layoutIphoneXNavTop:(NSLayoutConstraint *)layoutConstraint {
    //判断是否是iphoneX 做顶部距离约束处理
    if (KIsiPhoneX) {
        layoutConstraint.constant = 88;
    } else {
        layoutConstraint.constant = 64;
    }
}

@end
