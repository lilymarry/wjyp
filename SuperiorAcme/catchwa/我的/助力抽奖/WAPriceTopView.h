//
//  WAPriceTopView.h
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/16.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^turnViewBlock)(NSString * name);
@interface WAPriceTopView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (nonatomic, copy) turnViewBlock topBtnBlock;
@end

NS_ASSUME_NONNULL_END
