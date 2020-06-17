//
//  SWelfareAgency_play.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SWelfareAgency_play.h"
#import <AVKit/AVKit.h>
#import "SWelfareBonusList.h"
#import "UIImage+animatedGIF.h"

@interface SWelfareAgency_play ()
{
    BOOL playReady_isno;//是否可以播放
    BOOL play_isno;//播放暂停
    BOOL next_isno;//下一张是否可以
    
    AVPlayerItem * playerItem;
    AVPlayer * player;
    NSURL * videoURL;
    
    int secondsCountDown; //倒计时总时长
    NSTimer *countDownTimer;
    
    NSArray * model_arr;
    NSInteger model_num;//默认第一个
}
@end

@implementation SWelfareAgency_play

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"SWelfareAgency_play" owner:self options:nil];
        [self addSubview:_thisView];
        
        _thisImage.layer.masksToBounds = YES;
        _thisImage.layer.cornerRadius = 3;
        
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 20;
        [_submitBtn addTarget:self action:@selector(submitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        _comImage.layer.masksToBounds = YES;
        _comImage.layer.cornerRadius = _comImage.frame.size.width/2;
        
        _shareBtn.layer.masksToBounds = YES;
        _shareBtn.layer.cornerRadius = 20;
        [_shareBtn addTarget:self action:@selector(shareBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        _groundView.layer.masksToBounds = YES;
        _groundView.layer.cornerRadius = 10;
        
        _thisImageGround.layer.masksToBounds = YES;
        _thisImageGround.layer.cornerRadius = 10;
        
        [_playBtn addTarget:self action:@selector(playBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_playBtn setTag:0];
        
        

        _playerView.hidden = YES;
        [_submitBtn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        next_isno = NO;
    }
    return self;
}
- (void)showModel:(NSArray *)ads_list andLogo:(NSString *)logo andName:(NSString *)merchant_name {
    [_comImage sd_setImageWithURL:[NSURL URLWithString:logo] placeholderImage:[UIImage imageNamed:@"无界优品默认空视图"]];
    _comName.text = merchant_name;
    
    model_arr = ads_list;
    SWelfareBonusList * first = model_arr.firstObject;
    model_num = 1;
    _leftTitle.text = [NSString stringWithFormat:@"%zd/%zd",model_num,model_arr.count];
    if ([first.type isEqualToString:@"1"]) {
        //视频
        _thisImage.image = [UIImage imageNamed:@""];
        videoURL = [NSURL URLWithString:first.bonus_ads];
        [self show_vedio];
    } else {
        _playerView.hidden = YES;
        //图片
//        [_thisImage sd_setImageWithURL:[NSURL URLWithString:first.bonus_ads] placeholderImage:[UIImage imageNamed:@"无界优品默认正方形"]];
        _thisImage.image = [UIImage animatedImageWithAnimatedGIFURL:[NSURL URLWithString:first.bonus_ads]];
        secondsCountDown = [first.delay_time integerValue];//60秒倒计时
        countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 timeFireMethod
    }

}
- (void)show_vedio {
    _playerView.hidden = NO;
    _playActiv.hidden = NO;
    [_playActiv startAnimating];
    playerItem = [[AVPlayerItem alloc] initWithURL:videoURL];
    player = [[AVPlayer alloc] initWithPlayerItem:playerItem];
    // 初始化播放器的Layer
    AVPlayerLayer * playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    // layer的frame
    playerLayer.frame = CGRectMake(0, 0, ScreenW - 100, ScreenW - 100);
    // layer的填充属性 和UIImageView的填充属性类似
    // AVLayerVideoGravityResizeAspect 等比例拉伸，会留白
    // AVLayerVideoGravityResizeAspectFill // 等比例拉伸，会裁剪
    // AVLayerVideoGravityResize // 保持原有大小拉伸
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    // 把Layer加到底部View上
    [_playerView.layer insertSublayer:playerLayer atIndex:1];
    [playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
}
/** 数据处理 获取到观察到的数据 并进行处理 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    AVPlayerItem *item = object;
    if ([keyPath isEqualToString:@"loadedTimeRanges"]) {// 播放状态
        
        if (item.status == AVPlayerItemStatusReadyToPlay) {
            if (playReady_isno == NO) {
                playReady_isno = YES;
                _playActiv.hidden = YES;
                [_playActiv stopAnimating];
                [player play];
                
                NSDictionary *opts = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:NO]
                                                                 forKey:AVURLAssetPreferPreciseDurationAndTimingKey];
                AVURLAsset *urlAsset = [AVURLAsset URLAssetWithURL:videoURL options:opts];  // 初始化视频媒体文件
                int minute = 0, second = 0;
                second = urlAsset.duration.value / urlAsset.duration.timescale; // 获取视频总时长,单位秒
                //NSLog(@"movie duration : %d", second);
                if (second >= 60) {
                    int index = second / 60;
                    minute = index;
                    second = second - index*60;
                }
                
                //    NSLog(@"second:%d",second);
                
                secondsCountDown = second;//60秒倒计时
                countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 timeFireMethod
            }
        }
    }
}

#pragma mark - 播放暂停
- (void)playBtnClick:(UIButton *)btn {
    if (playReady_isno == NO || secondsCountDown <= 0) {
        return;
    }
    if (btn.tag == 0) {
        [player pause];
        [btn setTag:1];
        [_playBtn setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
        play_isno = YES;
        [countDownTimer invalidate];
    } else {
        [player play];
        [btn setTag:0];
        play_isno = NO;
        countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 timeFireMethod
        [_playBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
}
-(void)timeFireMethod{
    if (play_isno == NO) {
        //倒计时-1
        secondsCountDown--;
        //修改倒计时标签现实内容
        [_rightBtn setTitle:[NSString stringWithFormat:@"  %@",[self timeFormatted:secondsCountDown]] forState:UIControlStateNormal];
        
        //当倒计时到0时，做需要的操作，比如验证码过期不能提交
        if(secondsCountDown <= 0){
            [countDownTimer invalidate];
            [_rightBtn setTitle:@"  00:00" forState:UIControlStateNormal];
            [_submitBtn setBackgroundColor:[UIColor redColor]];
            next_isno = YES;

        } else {
            [_submitBtn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
            next_isno = NO;
        }
    }
}
- (NSString *)timeFormatted:(int)totalSeconds
{
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
//    int hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    _thisView.frame = self.bounds;
}
#pragma mark - 返回
- (IBAction)backBtn:(UIButton *)sender {
    [playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];

    if (self.SWelfareAgency_play_back) {
        self.SWelfareAgency_play_back();
    }
}
#pragma mark - 下一张
- (void)submitBtnClick {
    if (next_isno == NO) {
        return;
    }
    if (model_num < model_arr.count) {
        model_num ++;
        _leftTitle.text = [NSString stringWithFormat:@"%zd/%zd",model_num,model_arr.count];
        [_rightBtn setTitle:@"  --:--" forState:UIControlStateNormal];
        [_submitBtn setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
        next_isno = NO;
        SWelfareBonusList * now = model_arr[model_num - 1];
        if ([now.type isEqualToString:@"1"]) {
            //视频
            _thisImage.image = [UIImage imageNamed:@""];
            videoURL = [NSURL URLWithString:now.bonus_ads];
            [self show_vedio];
        } else {
            _playerView.hidden = YES;
            //图片
//            [_thisImage sd_setImageWithURL:[NSURL URLWithString:now.bonus_ads] placeholderImage:[UIImage imageNamed:@"无界优品默认正方形"]];
            _thisImage.image = [UIImage animatedImageWithAnimatedGIFURL:[NSURL URLWithString:now.bonus_ads]];
            secondsCountDown = [now.delay_time integerValue];//60秒倒计时
            countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES]; //启动倒计时后会每秒钟调用一次方法 timeFireMethod
        }
    } else {
        _thisImage.hidden = YES;
        _thisImageGround.hidden = YES;
        _leftTitle.hidden = YES;
        _rightBtn.hidden = YES;
        _submitBtn.hidden = YES;
    }
}
#pragma mark - 分享
- (void)shareBtnClick {
    [playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    if (self.SWelfareAgency_play_share) {
        self.SWelfareAgency_play_share();
    }
}
@end
