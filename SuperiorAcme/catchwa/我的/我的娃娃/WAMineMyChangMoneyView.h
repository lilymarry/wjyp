//
//  WAMineMyChangMoneyView.h
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/8.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^sureBtnAction)(void);
@interface WAMineMyChangMoneyView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property(copy,nonatomic)sureBtnAction block;
@property (strong, nonatomic) IBOutlet UILabel *moneyLab;


@end

NS_ASSUME_NONNULL_END
