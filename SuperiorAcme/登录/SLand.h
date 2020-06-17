//
//  SLand.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/27.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SLand_showModelBlock) ();

@interface SLand : UIViewController
@property (nonatomic, assign) BOOL modalPresent;//模态跳转，方便及时登录
@property (nonatomic, copy) SLand_showModelBlock SLand_showModel;
@property (nonatomic, strong) NSString * fag;
@end
