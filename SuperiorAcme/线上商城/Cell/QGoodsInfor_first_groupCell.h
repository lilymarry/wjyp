//
//  QGoodsInfor_first_groupCell.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/14.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGroupBuyGroupBuyInfo.h"

@interface QGoodsInfor_first_groupCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headerImage;
@property (strong, nonatomic) IBOutlet UILabel *rightTitle;
@property (strong, nonatomic) IBOutlet UILabel *nickname;
@property (strong, nonatomic) IBOutlet UILabel *lasTime;
@property (nonatomic, strong) SGroupBuyGroupBuyInfo * model;/// 可能有的不需要倒计时,如倒计时时间已到, 或者已经过了
@property (nonatomic, assign) BOOL needCountDown;/// 倒计时到0时回调
@property (nonatomic, copy) void(^countDownZero)();

/*
 *拼团倒计时相关
 */
@property (nonatomic, copy) NSString * countDownStr;

@property (assign, nonatomic) BOOL isBeginDelay;

@property (nonatomic, assign) BOOL isEnd;

/*
 *根据不同页面的需求,用于设置顶部和底部的分割线显示
 */
@property (weak, nonatomic) IBOutlet UIView *topSeparatorLineView;
@property (weak, nonatomic) IBOutlet UIView *bottomSeparatorLineView;

@end
