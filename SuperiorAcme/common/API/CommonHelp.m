//
//  CommonHelp.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/27.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "CommonHelp.h"

@implementation CommonHelp
//时间戳转时间
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString  andFormatter:(NSString *)format
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"beijing"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format];
    NSDate* date ;
    // 毫秒值转化为秒 // *1000 是精确到毫秒，不乘就是精确到秒
    if(timeString.length>13)
        
    {
        date = [NSDate dateWithTimeIntervalSince1970:[timeString longLongValue]/ 1000.0]; //返回的是13位的时间戳的话,是精确到了毫秒,需要除以1000
    }
    else
    {
        date = [NSDate dateWithTimeIntervalSince1970:[timeString longLongValue]];
    }
    
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}
#pragma mark - 将某个时间转化成 时间戳
+(NSString *)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format
{    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format];
    //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    //NSLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%ld",(long)timeSp); //时间戳的值
    NSString *str =[NSString stringWithFormat:@"%ld",(long)timeSp];
    return str;
    
}

@end
