//
//  WAMineMyWaListCell.m
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/16.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import "WAMineMyWaListCell.h"
#import "OYCountDownManager.h"
#import "CommonHelp.h"
@implementation WAMineMyWaListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _view_back.layer.masksToBounds = YES;
    _view_back.layer.cornerRadius = 15;
    _view_back.layer.borderWidth = 0.1;
    _view_back.layer.borderColor =[UIColor lightGrayColor].CGColor;
    
    _roomId.layer.masksToBounds = YES;
    _roomId.layer.cornerRadius = _roomId.frame.size.width/2;
    _roomId.layer.borderWidth = 0.1;
    _roomId.layer.borderColor =[UIColor clearColor].CGColor;
    
    _changeNumLab.layer.masksToBounds = YES;
    _changeNumLab.layer.cornerRadius = 1;
    _changeNumLab.layer.borderWidth = 1;
    _changeNumLab.layer.borderColor =[UIColor colorWithRed:252/255.0 green:73/255.0 blue:84/255.0 alpha:1].CGColor;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNotification)name:kCountDownNotification object:nil];
    
   
}

#pragma mark - 倒计时通知回调
- (void)countDownNotification {
   
    if (/* DISABLES CODE */ (0)) {
      
        return;
    }
    
    /// 计算倒计时
    NSInteger countDown = [self.start_time integerValue] - time(NULL) - kCountDownManager.timeInterval;
    if (countDown < 0)
        return;
    NSLog(@"sss11sdsdsd %@",[NSString stringWithFormat:@"剩余%02zd:%02zd:%02zd:%02zd",countDown/3600/24,countDown/3600%24, (countDown/60)%60, countDown%60]);
    
    /// 重新赋值
    _timeLab.text = [NSString stringWithFormat:@"%02zd天%02zd:%02zd:%02zd到期",countDown/3600/24,countDown/3600%24, (countDown/60)%60, countDown%60];
   
    /// 当倒计时到了进行回调
    if (countDown == 0) {
        if (self.countDownZero) {
            self.countDownZero();
        }
    }
}
-(void)setStart_time:(NSString *)start_time
{
    _start_time=start_time;
    // 手动调用通知的回调
    [self countDownNotification];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
