//
//  SGoodsInforCell4.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/19.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SGoodsInforCell4.h"
#import "OYCountDownManager.h"

@implementation SGoodsInforCell4


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNotification) name:kCountDownNotification object:nil];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        // 监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNotification) name:kCountDownNotification object:nil];
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
    
    // 手动调用通知的回调
    [self countDownNotification];
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
