//
//  CountDownManager.h
//  SuperiorAcme
//
//  Created by 科技沃天 on 2018/5/18.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^UpdateTimeBlock)(NSString * , BOOL isDelay);

typedef void(^TimerFinishCountDownBlock)(NSString * countDownTime);

@interface CountDownManager : NSObject

@property (nonatomic, copy) TimerFinishCountDownBlock timerFinishCountDownBlock;
@property (nonatomic, copy) UpdateTimeBlock updateTimeBlock;

-(id)initWithShowLabel:(UILabel *)showLabel andCountDownTime:(long long)countDownTime andTimeFormate:(NSString *)formate;

-(void)ReStartNewCountDownWithCountDownTime:(long long)newCountDownTime;

-(void)StopTimer;
@end
