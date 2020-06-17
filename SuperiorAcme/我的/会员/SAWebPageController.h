//
//  SAWebPageController.h
//  SuperiorAcme
//
//  Created by fxg on 2018/8/7.
//  Copyright © 2018年 GYM. All rights reserved.
//

typedef enum : NSUInteger {
    WEB_PAGE_TYPE_XUFEI_SUCCESS = 0,
    WEB_PAGE_TYPE_XUFEI_FAILURE,
} WEB_PAGE_TYPE;

#import <UIKit/UIKit.h>

@interface SAWebPageController : UIViewController

@property (nonatomic, assign) WEB_PAGE_TYPE type;

@end
