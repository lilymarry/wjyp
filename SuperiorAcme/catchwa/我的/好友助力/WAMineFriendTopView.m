//
//  WAMineFriendTopView.m
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/14.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import "WAMineFriendTopView.h"
#import "SYLineProgressView.h"
#import "OYCountDownManager.h"
@interface WAMineFriendTopView ()
@property (weak, nonatomic) IBOutlet UIButton *zhuliBtn;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, strong) SYLineProgressView *lineProgress;

@property (weak, nonatomic) IBOutlet UIView *lineProgressView;
@property (weak, nonatomic) IBOutlet UILabel *time_D;
@property (strong, nonatomic) IBOutlet UILabel *time_H;
@property (strong, nonatomic) IBOutlet UILabel *time_M;
@property (strong, nonatomic) IBOutlet UILabel *time_S;
@end

@implementation WAMineFriendTopView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"WAMineFriendTopView" owner:self options:nil];
        [self addSubview:_thisView];
      
        [self setUI];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(countDownNotification) name:kCountDownNotification object:nil];
        
     //   [self countDownNotification];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
- (void)setUI
{
    self.lineProgress = [[SYLineProgressView alloc] initWithFrame:CGRectMake(28, CGRectGetMaxY(_zhuliBtn.frame)+20+430+10, self.frame.size.width-56, 20)];
    [self addSubview:self.lineProgress];
    
    self.lineProgress.layer.cornerRadius = 10;
    self.lineProgress.lineWidth = 1.0;
    self.lineProgress.lineColor = [UIColor clearColor];
    self.lineProgress.progressColor =  [UIColor colorWithRed:237/255.0 green:111/255.0 blue:76/255.0 alpha:1];
    self.lineProgress.defaultColor = [UIColor colorWithRed:229/255.0 green:229/255.0 blue:229/255.0 alpha:1];
    self.lineProgress.label.textColor = [UIColor colorWithRed:241/255.0 green:158/255.0 blue:65/255.0 alpha:1];
    self.lineProgress.label.hidden = NO;
    [self.lineProgress initializeProgress];
    
    self.progress=0.5;//0-1;
    self.lineProgress.progress = self.progress;
    
    if ( self.progress ==0) {
         self.zhuliBtn.center = CGPointMake( self.progress * (self.frame.size.width - 56)+20,15);
    }
    else if (self.progress ==1)
    {
       self.zhuliBtn.center = CGPointMake( self.progress * (self.frame.size.width - 56)-30,15);
    }
    else
    {
       self.zhuliBtn.center = CGPointMake( self.progress * (self.frame.size.width - 56),15);
    }
    _helpBtn.layer.masksToBounds = YES;
    _helpBtn.layer.cornerRadius = 15;
    _helpBtn.layer.borderWidth = 0.1;
    _helpBtn.layer.borderColor =[UIColor clearColor].CGColor;
    
     _scrollView.contentSize = CGSizeMake(450, 0);
    for (UIImageView *TopView in _scrollView.subviews) {
        [TopView removeFromSuperview];
    }

    CGFloat  viewWidth =50;
    CGFloat  viewHeight =50;
    for (int i = 0 ; i < 7; i ++) {
        
        UIImageView *TopView = [[UIImageView alloc] initWithFrame:CGRectMake(10+(10+viewWidth)*i, 5, viewWidth, viewHeight-10)];
        TopView.layer.masksToBounds = YES;
        TopView.layer.cornerRadius = TopView.frame.size.width/2;
        TopView.layer.borderWidth = 0.1;
        TopView.layer.borderColor =[UIColor clearColor].CGColor;
        
        TopView.image=[UIImage imageNamed:@"首页默认娃娃图"];
       
        TopView.userInteractionEnabled=YES;
        
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        [bt setFrame:TopView.bounds];
        bt.tag = i;
        [bt addTarget:self action:@selector(whenClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [TopView addSubview:bt];
        
        [_scrollView addSubview:TopView];
    }
    _time_D.layer.masksToBounds = YES;
    _time_D.layer.cornerRadius = 3;
    
    _time_H.layer.masksToBounds = YES;
    _time_H.layer.cornerRadius = 3;
    
    _time_M.layer.masksToBounds = YES;
    _time_M.layer.cornerRadius = 3;
    
    _time_S.layer.masksToBounds = YES;
    _time_S.layer.cornerRadius = 3;
    
   
}
-(void)whenClick:(id)sender
{
    UIButton *button=(UIButton *)sender;
  //  NSLog(@"dcvx %ld",(long)button.tag);
    self.block((int)button.tag);
    
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
    
   NSString  *timei=[self timeSwitchTimestamp:@"2019-01-31 06:00:00" andFormatter:@"YYYY-MM-dd hh:mm:ss"];
  //  [self timeWithTimeIntervalString:timei andFormatter:@"YYYY-MM-dd hh:mm:ss"];
    
    NSInteger countDown = [timei integerValue]  - time(NULL) - kCountDownManager.timeInterval;
    if (countDown < 0) {
        _time_D.text = @"00";
        _time_H.text = @"00";
        _time_M.text = @"00";
        _time_S.text = @"00";
        return;
    }
    /// 重新赋值
    //    if (countDown/24 * 3600 ) {
    //        statements
    //    }
    _time_D.text = [NSString stringWithFormat:@"%02zd",countDown/3600/24];
    _time_H.text = [NSString stringWithFormat:@"%02zd",countDown/3600%24];
    _time_M.text = [NSString stringWithFormat:@"%02zd",(countDown/60)%60];
    _time_S.text = [NSString stringWithFormat:@"%02zd",countDown%60];
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

#pragma mark - 将某个时间转化成 时间戳
-(NSString *)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format
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
