//
//  SGoodsInfor_top.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/18.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGoodsInfor_top : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UIView *bannerView;
@property (strong, nonatomic) IBOutlet UILabel *end_time;//距离本场结束 00-37-42
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *nowPriceR_WWW;
@property (strong, nonatomic) IBOutlet UILabel *nowPrice;//现价
@property (strong, nonatomic) IBOutlet UILabel *oldPrice;//原价
@property (strong, nonatomic) IBOutlet UIView *oldPrice_Line;
@property (strong, nonatomic) IBOutlet UILabel *songR;
@property (strong, nonatomic) IBOutlet UILabel *integral_title;
@property (strong, nonatomic) IBOutlet UILabel *integral;
@property (strong, nonatomic) IBOutlet UILabel *daiR;
@property (strong, nonatomic) IBOutlet UILabel *goods_name;
@property (strong, nonatomic) IBOutlet UILabel *canR;
@property (strong, nonatomic) IBOutlet UILabel *pro_leftTitle;
@property (strong, nonatomic) IBOutlet UILabel *pro_rigthTitle;
@property (strong, nonatomic) IBOutlet UIProgressView *proBlue;
@property (strong, nonatomic) IBOutlet UILabel *proBlue_num;
@property (strong, nonatomic) IBOutlet UILabel *true_pre_money;
@property (strong, nonatomic) IBOutlet UILabel *all_price;

@property (strong, nonatomic) IBOutlet UILabel *cityPrice;

@property (strong, nonatomic) IBOutlet UIView *fiveView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *fiveView_HHH;
@property (strong, nonatomic) IBOutlet UIView *sixView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sixView_HHH;

@property (strong, nonatomic) IBOutlet UIImageView *country_logo;
@property (strong, nonatomic) IBOutlet UILabel *country_desc;
@property (strong, nonatomic) IBOutlet UIView *twoView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *twoView_HHH;
@property (strong, nonatomic) IBOutlet UIView *sevenView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sevenView_HHH;
@property (strong, nonatomic) IBOutlet UIView *eightView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *eightView_HHH;
@end
