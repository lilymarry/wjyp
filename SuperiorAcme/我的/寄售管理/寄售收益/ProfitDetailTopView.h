//
//  ProfitDetailTopView.h
//  SuperiorAcme
//
//  Created by 天津沃天科技 on 2019/4/8.
//  Copyright © 2019年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfitDetailTopView : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UIView *dataView;
@property (strong, nonatomic) IBOutlet UIImageView *headView;
@property (strong, nonatomic) IBOutlet UILabel *mygradeLab;
@property (strong, nonatomic) IBOutlet UILabel *myProfitLab;
@property (strong, nonatomic) IBOutlet UILabel *myNameLab;

/**
 周按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *weekButton;

/**
 月按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *monthButton;

/**
 年按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *yearButton;

/**
 周，月，年背景视图
 */
@property (weak, nonatomic) IBOutlet UIView *timeTypeindexView;


/**
 统计视图背景视图
 */
@property (weak, nonatomic) IBOutlet UIView *statisticsView;

/**
 7个时间段的背景视图
 */
@property (weak, nonatomic) IBOutlet UIView *statisticsTitleView;
/**
 以下为7个时间段的标题
 */
@property (weak, nonatomic) IBOutlet UILabel *timeLabel1;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel2;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel3;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel4;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel5;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel6;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel7;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineCenterX;

@end

NS_ASSUME_NONNULL_END
