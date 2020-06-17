//
//  SGoodsInforCell4.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/19.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGroupBuyGroupBuyInfo.h"

@interface SGoodsInforCell4 : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headerImage;
@property (strong, nonatomic) IBOutlet UILabel *rightTitle;
@property (strong, nonatomic) IBOutlet UILabel *nickname;
@property (strong, nonatomic) IBOutlet UILabel *lasTime;

@property (nonatomic, strong) SGroupBuyGroupBuyInfo * model;
/// 可能有的不需要倒计时,如倒计时时间已到, 或者已经过了
@property (nonatomic, assign) BOOL needCountDown;
/// 倒计时到0时回调
@property (nonatomic, copy) void(^countDownZero)();
@end
