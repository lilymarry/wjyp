//
//  CountDownManager.m
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/5/18.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import "CountDownManager.h"
#import "WN_Stopwatch.h"

@interface CountDownManager ()<WN_StopWatchDelegate>
{
    WN_Stopwatch * stopWatchLabel;
}

@property (nonatomic, assign) NSUInteger alreadyRunTimes;
@property (nonatomic, assign) BOOL isDelay;

@property (nonatomic, weak) UILabel * showLabel;
@property (nonatomic, strong) NSString * timeFormate;

@end

@implementation CountDownManager

-(id)initWithShowLabel:(UILabel *)showLabel andCountDownTime:(long long)countDownTime andTimeFormate:(NSString *)formate{
    self.showLabel = showLabel;
    self.timeFormate = formate;
    self.alreadyRunTimes = 0;
    [self CreatCountDownTimerWithShowLabel:showLabel andCountDownTime:countDownTime andTimeFormate:formate];
    
    
    return [self init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        //初始化其他操作
    }
    return self;
}

//初始化倒计时定时器
-(void)CreatCountDownTimerWithShowLabel:(UILabel *)showLabel andCountDownTime:(long long)countDownTime andTimeFormate:(NSString *)formate{
    self.alreadyRunTimes++;
    if (self.alreadyRunTimes <= 2) {
        if (self.alreadyRunTimes == 2) {
            self.isDelay = YES;
        }else{
            self.isDelay = NO;
        }
        if (!stopWatchLabel) {
            stopWatchLabel = [[WN_Stopwatch alloc]initWithLabel:showLabel andTimerType:WNTypeTimer];
            stopWatchLabel.delegate = self;
            [stopWatchLabel setTimeFormat:formate];
            [stopWatchLabel setCountDownTime:countDownTime];//多少秒 （1分钟 == 60秒）
            [stopWatchLabel start];//直接开始倒计时
            __weak typeof(self) WeakSelf = self;
            stopWatchLabel.timerUpdateBlock = ^(NSString * updateTimeStr ) {
                if (WeakSelf.updateTimeBlock) {
                    WeakSelf.updateTimeBlock(updateTimeStr,WeakSelf.isDelay);
                }
            };
        }
    }
}

//时间到了
-(void)timerLabel:(WN_Stopwatch*)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    
    [stopWatchLabel reset];
    stopWatchLabel = nil;
    if (self.timerFinishCountDownBlock) {
        self.timerFinishCountDownBlock([NSString stringWithFormat:@"%f",countTime]);
    }
    
}

//开始倒计时
-(void)timerLabel:(WN_Stopwatch*)timerlabel
       countingTo:(NSTimeInterval)time
        timertype:(WN_StopwatchLabelType)timerType {
//    NSLog(@"time:%f",time);
    
}

//重新开启倒计时
-(void)ReStartNewCountDownWithCountDownTime:(long long)newCountDownTime{
    [self CreatCountDownTimerWithShowLabel:self.showLabel andCountDownTime:newCountDownTime andTimeFormate:self.timeFormate];
}

-(void)StopTimer{
    [stopWatchLabel invalidateTimer];
}
@end
