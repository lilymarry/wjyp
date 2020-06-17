//
//  SResetPayPass.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/21.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSet.h"
#import "SLand.h"

@interface SResetPayPass : UIViewController
@property (nonatomic, strong) SSet * setttt;//修改支付密码需要
@property (nonatomic, strong) SLand * landddd;//修改登录密码需要

/*
 *获取绑定的手机号
 */
@property (nonatomic, strong) NSString * iPhone;
@end
