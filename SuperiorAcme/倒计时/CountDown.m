
//
//  CountDown.m
//  倒计时
//
//  Created by Maker on 16/7/5.
//  Copyright © 2016年 郑文明. All rights reserved.
//

#import "CountDown.h"

@interface CountDown ()
@property(nonatomic,retain) dispatch_source_t timer;
@property(nonatomic,retain) NSDateFormatter *dateFormatter;



@property (copy, nonatomic) NSString * dayStr;
@property (copy, nonatomic) NSString * hourStr;
@property (copy, nonatomic) NSString * minuteStr;
@property (copy, nonatomic) NSString * secondStr;


@end

@implementation CountDown
- (instancetype)init{
    self = [super init];
    if (self) {
        self.dateFormatter=[[NSDateFormatter alloc] init];
        [self.dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
          NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
         [self.dateFormatter setTimeZone:localTimeZone];
    }
    return self;
}

-(void)countDownWithStratDate:(NSDate *)startDate finishDate:(NSDate *)finishDate completeBlock:(void (^)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second))completeBlock{
    if (_timer==nil) {
        NSTimeInterval timeInterval =[finishDate timeIntervalSinceDate:startDate];
        __block int timeout = timeInterval; //倒计时时间
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(0,0,0,0);
                    });
                }else{
                    int days = (int)(timeout/(3600*24));
                    int hours = (int)((timeout-days*24*3600)/3600);
                    int minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    int second = timeout-days*24*3600-hours*3600-minute*60;
                    
                    if (!_isShowDAYS) {//不显示时间的话,将天数对应的小时数,加到小时上
                        hours += 24 * days;
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(days,hours,minute,second);
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }
    }
}
-(void)countDownWithPER_SECBlock:(void (^)())PER_SECBlock{
    if (_timer==nil) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),0.01*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                dispatch_async(dispatch_get_main_queue(), ^{
                    PER_SECBlock();
                });
            });
            dispatch_resume(_timer);
    }
}
-(NSDate *)dateWithLongLong:(long long)longlongValue{
    NSString * valueStr = [NSString stringWithFormat:@"%lld",longlongValue];
    long long value = 0;
    if (valueStr.length > 13) {//返回的是13位的时间戳的话,是精确到了毫秒,需要除以1000
         value = longlongValue/1000;
    }else{                     //返回的是10位的时间戳的话,是精确到秒,不需要再除以1000,否则日期会变成1970年,出现时间错乱
        value = longlongValue;
    }
    NSNumber *time = [NSNumber numberWithLongLong:value];
    //转换成NSTimeInterval,用longLongValue，防止溢出
    NSTimeInterval nsTimeInterval = [time longLongValue];
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:nsTimeInterval];
    return date;
}
-(void)countDownWithStratTimeStamp:(long long)starTimeStamp finishTimeStamp:(long long)finishTimeStamp completeBlock:(void (^)(NSInteger day,NSInteger hour,NSInteger minute,NSInteger second))completeBlock{
    if (_timer==nil) {
        NSDate *finishDate = [self dateWithLongLong:finishTimeStamp];
        NSDate *startDate  = [self dateWithLongLong:starTimeStamp];
        NSTimeInterval timeInterval =[finishDate timeIntervalSinceDate:startDate];
        __block int timeout = timeInterval; //倒计时时间
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(0,0,0,0);
                    });
                }else{
                    int days = (int)(timeout/(3600*24));
                    int hours = (int)((timeout-days*24*3600)/3600);
                    int minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    int second = timeout-days*24*3600-hours*3600-minute*60;
                    
                    if (!_isShowDAYS) {//不显示时间的话,将天数对应的小时数,加到小时上
                        hours += 24 * days;
                    }
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        completeBlock(days,hours,minute,second);
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }
    }
}
/**
 *  获取当天的年月日的字符串
 *  @return 格式为年-月-日
 */
-(NSString *)getNowyyyymmdd{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatDay = [[NSDateFormatter alloc] init];
    formatDay.dateFormat = @"yyyy-MM-dd";
    NSString *dayStr = [formatDay stringFromDate:now];
    return dayStr;
}
/**
 *  主动销毁定时器
 *  @return 格式为年-月-日
 */
-(void)destoryTimer{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

-(void)dealloc{
    NSLog(@"%s dealloc",object_getClassName(self));
}







/*
 *刷新UI
 */
-(void)refreshWithStartLongLongStartStamp:(long long)strtLL longlongFinishStamp:(long long)finishLL completeBlock:(void (^)(NSString * day,NSString * hour,NSString * minute,NSString * second))completeBlock{
    
    [self countDownWithStratTimeStamp:strtLL finishTimeStamp:finishLL completeBlock:^(NSInteger day, NSInteger hour, NSInteger minute, NSInteger second) {
        
        if (day==0) {
            self.dayStr = @"0天";
        }else{
            self.dayStr = [NSString stringWithFormat:@"%ld天",(long)day];
        }
        if (hour<10) {
            self.hourStr = [NSString stringWithFormat:@"0%ld",(long)hour];
        }else{
            self.hourStr = [NSString stringWithFormat:@"%ld",(long)hour];
        }
        if (minute<10) {
            self.minuteStr = [NSString stringWithFormat:@"0%ld",(long)minute];
        }else{
            self.minuteStr = [NSString stringWithFormat:@"%ld",(long)minute];
        }
        if (second<10) {
            self.secondStr = [NSString stringWithFormat:@"0%ld",(long)second];
        }else{
            self.secondStr = [NSString stringWithFormat:@"%ld",(long)second];
        }
        
        completeBlock(self.dayStr,self.hourStr,self.minuteStr,self.secondStr);
        
    }];
}


@end
