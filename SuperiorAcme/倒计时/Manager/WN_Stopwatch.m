//
//  WN_Stopwatch.m
//  Stopwatch
//
//  Created by Transuner on 16/4/28.
//  Copyright © 2016年 王宁. All rights reserved.
//

#import "WN_Stopwatch.h"

#define kDefaultTimeFormat  @"HH:mm:ss"
#define kDefaultFireIntervalNormal  0.1
#define kDefaultFireIntervalHighUse  0.05
@interface WN_Stopwatch (){
    NSDate * date1970;
    NSDate * startCountDate;
    NSDate * pausedTime;
    NSDate * timeToCountOff;
    NSTimeInterval timeUserValue;
#if NS_BLOCKS_AVAILABLE
    void (^endedBlock)(NSTimeInterval);
#endif
}
@property (nonatomic,strong) NSTimer *timer;
//时间分割的标志
@property (nonatomic, copy) NSString * separatorStr;
@end

@implementation WN_Stopwatch

- (instancetype) init {
    if (self = [super init]) {
        _timeLabel = self;
        _stopwatchLabelType = WNTypeStopWatch;
    }
    return self;
}

- (instancetype) initWithLabel:(UILabel *)anLabel andTimerType:(WN_StopwatchLabelType)anType {
    
    if (self = [super init]) {
        
        _timeLabel = anLabel;
        _stopwatchLabelType = anType;
        [self setup];
    }
    return self;
}

- (void) setup {
    if (_timeFormat.length == 0) {
        _timeFormat = kDefaultTimeFormat;
    }
    if (!_timeLabel) {
        _timeLabel = self;
    }
    date1970 = [NSDate dateWithTimeIntervalSince1970:0];
    
    _timeLabel.adjustsFontSizeToFitWidth = YES;
    [self updateLabel:nil];
}

- (void) updateLabel:(NSTimer *) timer {
    
    NSTimeInterval timeDieff = [[[NSDate alloc]init]timeIntervalSinceDate:startCountDate];
    NSDate * timeToShow = [NSDate date];
    NSTimeInterval timeLeft = 0.0;
    
    if (_stopwatchLabelType == WNTypeStopWatch) {
        if (_counting) {
            timeToShow = [date1970 dateByAddingTimeInterval:timeDieff];
        } else {
            timeToShow = [date1970 dateByAddingTimeInterval:(!startCountDate)?0:timeDieff];
        }
        if ([_delegate respondsToSelector:@selector(timerLabel:countingTo:timertype:)]) {
            [_delegate timerLabel:self countingTo:timeDieff timertype:_stopwatchLabelType];
        }
    } else {
        
        if (_counting) {
            
            if ([_delegate respondsToSelector:@selector(timerLabel:countingTo:timertype:)]) {
                timeLeft = timeUserValue - timeDieff;
                [_delegate timerLabel:self countingTo:timeLeft timertype:_stopwatchLabelType];
            }
            if (fabs(timeDieff) >= timeUserValue) {
                [self pause];
                timeToShow = [date1970 dateByAddingTimeInterval:0];
                pausedTime = nil;
                startCountDate = nil;
                
                if([_delegate respondsToSelector:@selector(timerLabel:finshedCountDownTimerWithTime:)]){
                    [_delegate timerLabel:self finshedCountDownTimerWithTime:timeUserValue];
                }
#if NS_BLOCKS_AVAILABLE
                if(endedBlock != nil){
                    endedBlock(timeUserValue);
                }
#endif
                if(_resetTimerAfterFinish){
                    [self reset];
                    return;
                }
                
            }else{
                timeToShow = [timeToCountOff dateByAddingTimeInterval:(timeDieff*-1)];
            }
            
        }else{
            timeToShow = timeToCountOff;
        }
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:_timeFormat];
    long days = (int)(timeLeft/(3600*24));
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    NSString *strDate = [dateFormatter stringFromDate:timeToShow];

    
    NSMutableArray * tempArr = [[strDate componentsSeparatedByString:self.separatorStr] mutableCopy];
    if (tempArr.count <= 0) {
        return;
    }
//    NSString * firstItemStr = tempArr.firstObject;
//    if (firstItemStr.integerValue + days * 24 < 10) {
//        firstItemStr = [NSString stringWithFormat:@"0%ld",firstItemStr.integerValue + days * 24];
//    }else{
//        firstItemStr = [NSString stringWithFormat:@"%ld",firstItemStr.integerValue + days * 24];
//    }
//    [tempArr replaceObjectAtIndex:0 withObject:firstItemStr];
    
    NSString * newDateStr = nil;
    if ([self.timeLabel isMemberOfClass:[UILabel class]]) {
        newDateStr = [tempArr componentsJoinedByString:self.separatorStr];
    }else{
        newDateStr = [tempArr componentsJoinedByString:[NSString stringWithFormat:@" %@ ",self.separatorStr]];
    }
    
    newDateStr = [[NSString stringWithFormat:@"%02lu 天 ",days] stringByAppendingString:newDateStr];
    
    //更新的时间的回调
    if (self.timerUpdateBlock) {
        self.timerUpdateBlock(newDateStr);
    }
}

- (void) pause {
    
    [_timer invalidate];
    _timer = nil;
    _counting = NO;
    pausedTime = [NSDate date];
}

- (void) reset {
    
    pausedTime = nil;
    
    if(_stopwatchLabelType == WNTypeStopWatch) timeUserValue = 0;
    
    if(_counting){
        startCountDate = [NSDate date];
    }else{
        startCountDate = nil;
    }
    
    [self updateLabel:nil];
}

-(void)invalidateTimer{
    
    [_timer invalidate];
    _timer = nil;
}

#if NS_BLOCKS_AVAILABLE
-(void)startWithEndingBlock:(void(^)(NSTimeInterval))end{
    [self start];
    endedBlock = end;
}
#endif


-(void)start{
    
    [self setup];
    if(_timer == nil){
        
        if ([_timeFormat rangeOfString:@"SS"].location != NSNotFound) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:kDefaultFireIntervalHighUse target:self selector:@selector(updateLabel:) userInfo:nil repeats:YES];
        }else{
            _timer = [NSTimer scheduledTimerWithTimeInterval:kDefaultFireIntervalNormal target:self selector:@selector(updateLabel:) userInfo:nil repeats:YES];
        }
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        
        if(startCountDate == nil){
            startCountDate = [NSDate date];
            
            if (_stopwatchLabelType == WNTypeStopWatch && timeUserValue > 0) {
                startCountDate = [startCountDate dateByAddingTimeInterval:(timeUserValue<0)?0:-timeUserValue];
            }
        }
        if(pausedTime != nil){
            NSTimeInterval countedTime = [pausedTime timeIntervalSinceDate:startCountDate];
            startCountDate = [[NSDate date] dateByAddingTimeInterval:-countedTime];
            pausedTime = nil;
        }
        
        _counting = YES;
        [_timer fire];
        
    }
}

-(void)setStopWatchTime:(NSTimeInterval)time{
    
    timeUserValue = (time < 0) ? 0 : time;
    if(timeUserValue > 0){
        startCountDate = [[NSDate date] dateByAddingTimeInterval:(timeUserValue<0)?0:-timeUserValue];
        [self start];
        [self updateLabel:nil];
        [self pause];
    }
}

-(void)setCountDownTime:(NSTimeInterval)time{
    
    timeUserValue = time;
    timeToCountOff = [date1970 dateByAddingTimeInterval:time];
    [self updateLabel:nil];
}

-(void)setTimeFormat:(NSString *)timeFormat{
    
    _timeFormat = timeFormat;
    if ([_timeFormat length] != 0) {
        _timeFormat = timeFormat;
        
        if ([timeFormat containsString:@"ss"]) {
            NSRange range = [timeFormat rangeOfString:@"ss"];
            self.separatorStr = [timeFormat substringWithRange:NSMakeRange(range.location - 1, 1)];
        }
    }
    [self updateLabel:nil];
}
@end
