//
//  WAMineFriendTopView.h
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/14.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^tapImaAction)(int imaTag);
@interface WAMineFriendTopView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (weak, nonatomic) IBOutlet UIButton *helpBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
/// 可能有的不需要倒计时,如倒计时时间已到, 或者已经过了
@property (nonatomic, assign) BOOL needCountDown;
/// 倒计时到0时回调
@property (nonatomic, copy) void(^countDownZero)(void);

@property(copy,nonatomic)tapImaAction block;
@end

NS_ASSUME_NONNULL_END
