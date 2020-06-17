//
//  SOnlineShopCell.m
//  SuperiorAcme
//
//  Created by GYM on 2017/7/6.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import "SOnlineShopCell.h"
#import "OYCountDownManager.h"

@implementation SOnlineShopCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 监听通知
    
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
   // NSLog(@"SSSS %@",self.model.end_time);
    NSInteger countDown = [self.model.end_time integerValue] - time(NULL) - kCountDownManager.timeInterval;
    if (countDown < 0) {
        _time_D.text = @"00";
        _time_H.text = @"00";
        _time_M.text = @"00";
        _time_S.text = @"00";
        return;
    }
    /// 重新赋值
//    if (countDown/24 * 3600 ) {
//        <#statements#>
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

///  重写setter方法
- (void)setModel:(SAuctionAuctionIndex *)model {
    _model = model;
    
    // 手动调用通知的回调
    [self countDownNotification];
}

/*
 *无界商店模型
 */
-(void)setWuJieShopModel:(id)WuJieShopModel{
    _WuJieShopModel = WuJieShopModel;
    /*
     *无界商店中的商品列表,兑换需要积分前添加图片
     */
    if ([WuJieShopModel isKindOfClass:NSClassFromString(@"SIntegralBuyIntegralBuyIndex")] ||//无界商城首页
        [WuJieShopModel isKindOfClass:NSClassFromString(@"SIntegralBuyThreeList")]) {//无界商城三级列表
        [self.goods_priceOne LabelAddImageWithImageName:@"需"];
    }
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _integral_R.layer.masksToBounds = YES;
    _integral_R.layer.cornerRadius = _integral_R.frame.size.width/2;
    
    _blue_pro.layer.masksToBounds = YES;
    _blue_pro.layer.cornerRadius =3;
    _blue_pro.layer.borderWidth = 0.5;
    _blue_pro.layer.borderColor = MyBlue.CGColor;
    
    _top_oneTitle.layer.masksToBounds = YES;
    _top_oneTitle.layer.cornerRadius = 3;
    
    _red_pro.layer.masksToBounds = YES;
    _red_pro.layer.cornerRadius =3;
    
    _car_R.layer.masksToBounds = YES;
    _car_R.layer.cornerRadius =3;
    
    _time_D.layer.masksToBounds = YES;
    _time_D.layer.cornerRadius = 3;
    
    _time_H.layer.masksToBounds = YES;
    _time_H.layer.cornerRadius = 3;
    
    _time_M.layer.masksToBounds = YES;
    _time_M.layer.cornerRadius = 3;
    
    _time_S.layer.masksToBounds = YES;
    _time_S.layer.cornerRadius = 3;

    _time_submit.layer.masksToBounds = YES;
    _time_submit.layer.cornerRadius = 3;
    
//    _top_oneImage.layer.masksToBounds = YES;
//    _top_oneImage.layer.cornerRadius = 3;
//    _top_oneImage.layer.borderWidth = 0.5;
//    _top_oneImage.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
}

@end
