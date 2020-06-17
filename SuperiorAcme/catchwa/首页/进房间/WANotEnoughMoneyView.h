//
//  WANotEnoughMoneyView.h
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/14.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^TopBtnBlock)(void);
@interface WANotEnoughMoneyView : UIView
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (weak, nonatomic) IBOutlet UIButton *oneBtn;
@property (nonatomic, copy) TopBtnBlock topBtnBlock;

@end

NS_ASSUME_NONNULL_END
