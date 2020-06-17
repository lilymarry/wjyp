//
//  WN_Stopwatch.h
//  Stopwatch
//
//  Created by Transuner on 16/4/28.
//  Copyright © 2016年 王宁. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,WN_StopwatchLabelType){
    WNTypeStopWatch,
    WNTypeTimer
};


typedef void(^TimerUpdateBlock)(NSString *);

@class WN_Stopwatch;
@protocol WN_StopWatchDelegate <NSObject>

@optional

//倒计时结束
-(void)timerLabel:(WN_Stopwatch*)timerLabel
finshedCountDownTimerWithTime:(NSTimeInterval)countTime;

//倒计时中
-(void)timerLabel:(WN_Stopwatch*)timerlabel
       countingTo:(NSTimeInterval)time
        timertype:(WN_StopwatchLabelType)timerType;

@end

@interface WN_Stopwatch : UILabel

@property (assign,readonly) BOOL counting;//倒计时中状态
@property (nonatomic, assign) BOOL resetTimerAfterFinish;//结束后重置倒计时

@property (nonatomic, strong) UILabel * timeLabel;

@property (nonatomic, strong) NSString * timeFormat;//时间格式

@property (nonatomic, assign) WN_StopwatchLabelType stopwatchLabelType;//倒计时类型

@property (nonatomic, copy) TimerUpdateBlock timerUpdateBlock;//倒计时类型

@property (nonatomic, strong) id<WN_StopWatchDelegate>delegate;//代理对象

- (instancetype) initWithLabel:(UILabel *)anLabel
                  andTimerType:(WN_StopwatchLabelType)anType;

-(void)start;
#if NS_BLOCKS_AVAILABLE
-(void)startWithEndingBlock:(void(^)(NSTimeInterval countTime))end;
#endif

-(void)pause;
-(void)reset;
-(void)invalidateTimer;
-(void)setCountDownTime:(NSTimeInterval)time;
-(void)setStopWatchTime:(NSTimeInterval)time;

@end
