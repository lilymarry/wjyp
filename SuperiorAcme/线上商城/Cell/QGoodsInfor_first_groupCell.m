//
//  QGoodsInfor_first_groupCell.m
//  SuperiorAcme
//
//  Created by GYM on 2017/11/14.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "QGoodsInfor_first_groupCell.h"
#import "OYCountDownManager.h"

@interface QGoodsInfor_first_groupCell ()

@end


@implementation QGoodsInfor_first_groupCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 监听通知 //旧代码
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNotification) name:kCountDownNotification object:nil];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        // 监听通知 //旧代码
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNotification) name:kCountDownNotification object:nil];
    }
    return self;
}
#pragma mark - 倒计时通知回调
- (void)countDownNotification {
    /// 判断是否需要倒计时 -- 可能有的cell不需要倒计时,根据真实需求来进行判断
    if (/* DISABLES CODE */ (0)) {
        //        _expired_time.hidden = YES;
        //        _expired_time_title.hidden = YES;
        //
        return;
    }
    //    _expired_time.hidden = NO;
    //    _expired_time_title.hidden = NO;
    /// 计算倒计时
    NSInteger countDown = [self.model.start_time integerValue] - time(NULL) - kCountDownManager.timeInterval;
    if (countDown < 0) return;
    /// 重新赋值
    _lasTime.text = [NSString stringWithFormat:@"%@，剩余%02zd:%02zd:%02zd:%02zd",self.model.diff,countDown/3600/24,countDown/3600%24, (countDown/60)%60, countDown%60];
    //    _time_H.text = [NSString stringWithFormat:@"%02zd",countDown/3600];
    //    _time_M.text = [NSString stringWithFormat:@"%02zd",(countDown/60)%60];
    //    _time_S.text = [NSString stringWithFormat:@"%02zd",countDown%60];
    //    NSLog(@"H:%02zd",countDown/3600);
    //    NSLog(@"M:%02zd",(countDown/60)%60);
    //    NSLog(@"时间：———————%@—————",[NSString stringWithFormat:@"%02zd:%02zd:%02zd", countDown/3600, (countDown/60)%60, countDown%60]);
    /// 当倒计时到了进行回调
    if (countDown == 0) {
        //        _expired_time.hidden = YES;
        //        _expired_time_title.hidden = YES;
        if (self.countDownZero) {
            self.countDownZero();
        }
    }
}


///  重写setter方法
- (void)setModel:(SGroupBuyGroupBuyInfo *)model {
    _model = model;
    
    // 手动调用通知的回调 //旧代码
    //    [self countDownNotification];
    
}

/*
 *更新显示倒计时
 */
-(void)setCountDownStr:(NSString *)countDownStr{
    _countDownStr = countDownStr;
     if (self.model.diff != nil) {//团购是否
         if (self.isBeginDelay) {
             self.lasTime.text = [NSString stringWithFormat:@"%@ (已延迟)剩余%@",self.model.diff,countDownStr];
         }else{
             self.lasTime.text = [NSString stringWithFormat:@"%@ 剩余%@",self.model.diff,countDownStr];
         }
     }else{
         if (self.isBeginDelay) {
             self.lasTime.text = [NSString stringWithFormat:@"(已延迟)剩余%@",countDownStr];
         }else{
             self.lasTime.text = [NSString stringWithFormat:@"剩余%@",countDownStr];
         }
     }
    
}
/*
 *当当前cell的倒计时结束的时候,设置显示为00:00:00:00
 */
-(void)setIsEnd:(BOOL)isEnd{
    _isEnd = isEnd;
    if (isEnd) {
        self.countDownStr = @"00:00:00:00";
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _headerImage.layer.masksToBounds = YES;
    _headerImage.layer.cornerRadius = _headerImage.frame.size.width/2;
    _rightTitle.layer.masksToBounds = YES;
    _rightTitle.layer.cornerRadius = 3;
}

@end
