//
//  SModifyLoginPassword.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/21.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSet.h"

@interface SModifyLoginPassword : UIViewController
@property (nonatomic, assign) BOOL type;//NO修改登录密码 YES修改支付密码
@property (nonatomic, assign) BOOL set_type;//NO未设置 YES已设置

@property (nonatomic, strong) SSet * setttt;//修改支付密码需要

/*
 *获取绑定的手机号
 */
@property (nonatomic, strong) NSString * iPhone;
@end
