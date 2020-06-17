//
//  SPay_Pass.h
//  SuperiorAcme
//
//  Created by GYM on 2018/2/9.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SPay_Pass_backBlock) ();
typedef void(^SPay_Pass_setBlock) ();

@interface SPay_Pass : UIViewController

@property (nonatomic, copy) SPay_Pass_backBlock SPay_Pass_back;
@property (nonatomic, copy) SPay_Pass_setBlock SPay_Pass_set;
@end
