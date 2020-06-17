//
//  SSearch.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/14.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SearchType_online = 0, //默认
    SearchType_underline,
} SearchType;

@interface SSearch : UIViewController

@property (nonatomic, assign) SearchType searchType;

@end
