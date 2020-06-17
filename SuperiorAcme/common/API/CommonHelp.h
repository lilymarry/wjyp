//
//  CommonHelp.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/3/27.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonHelp : NSObject
//时间戳转时间
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString  andFormatter:(NSString *)format;
// 将某个时间转化成 时间戳
+(NSString *)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
