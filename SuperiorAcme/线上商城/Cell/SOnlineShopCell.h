//
//  SOnlineShopCell.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/6.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAuctionAuctionIndex.h"//竞拍汇
/*
 *添加自定义的label,实现富文本
 */
#import "CustomLabel.h"

@interface SOnlineShopCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIView *top_oneView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *top_oneView_HHH;
@property (strong, nonatomic) IBOutlet UIImageView *top_oneImage;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *top_oneImage_WWW;
@property (strong, nonatomic) IBOutlet UILabel *top_oneTitle;

@property (strong, nonatomic) IBOutlet UIImageView *goodsImage;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *goodsImage_HHH;

@property (strong, nonatomic) IBOutlet UIView *top_twoView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *top_twoView_HHH;
@property (strong, nonatomic) IBOutlet UILabel *top_twoTitle;

@property (strong, nonatomic) IBOutlet UILabel *goodsTitle;

@property (strong, nonatomic) IBOutlet UIView *houseView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *houseView_HHH;
@property (strong, nonatomic) IBOutlet UILabel *house_titleSub;
@property (strong, nonatomic) IBOutlet UILabel *house_around;
@property (strong, nonatomic) IBOutlet UILabel *house_num;

@property (strong, nonatomic) IBOutlet UIView *goods_PriceView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *goods_priceHHH;
@property (strong, nonatomic) IBOutlet CustomLabel *goods_priceOne;
@property (strong, nonatomic) IBOutlet UILabel *goods_priceTwo;
@property (strong, nonatomic) IBOutlet UIView *goods_priceTwo_line;

@property (strong, nonatomic) IBOutlet UIView *redView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *redView_HHH;
@property (strong, nonatomic) IBOutlet UIProgressView *red_pro;
@property (strong, nonatomic) IBOutlet UILabel *red_num;
@property (strong, nonatomic) IBOutlet UILabel *red_numSub;
@property (strong, nonatomic) IBOutlet UILabel *red_title_1;
@property (strong, nonatomic) IBOutlet UILabel *red_title_2;

@property (strong, nonatomic) IBOutlet UIView *carView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *carView_HHH;
@property (strong, nonatomic) IBOutlet UILabel *car_R;
@property (strong, nonatomic) IBOutlet UILabel *car_price;
@property (strong, nonatomic) IBOutlet UILabel *car_priceContent;
@property (strong, nonatomic) IBOutlet UILabel *car_priceAll;

@property (strong, nonatomic) IBOutlet UIView *integralView;
@property (strong, nonatomic) IBOutlet UILabel *integral_R;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *integral_HHH;
@property (strong, nonatomic) IBOutlet UILabel *integral_price;
@property (strong, nonatomic) IBOutlet UILabel *integral_num;

@property (strong, nonatomic) IBOutlet UIView *timeView;
@property (weak, nonatomic) IBOutlet UILabel *timeOver;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *timeView_HHH;
@property (weak, nonatomic) IBOutlet UILabel *time_D;
@property (strong, nonatomic) IBOutlet UILabel *time_H;
@property (strong, nonatomic) IBOutlet UILabel *time_M;
@property (strong, nonatomic) IBOutlet UILabel *time_S;
@property (strong, nonatomic) IBOutlet UIButton *time_submit;

@property (strong, nonatomic) IBOutlet UIView *blueView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *blueView_HHH;
@property (strong, nonatomic) IBOutlet UIProgressView *blue_pro;
@property (strong, nonatomic) IBOutlet UILabel *blue_proNum;
@property (strong, nonatomic) IBOutlet UILabel *blue_Num;


@property (nonatomic, strong) SAuctionAuctionIndex * model;
/// 可能有的不需要倒计时,如倒计时时间已到, 或者已经过了
@property (nonatomic, assign) BOOL needCountDown;
/// 倒计时到0时回调
@property (nonatomic, copy) void(^countDownZero)();


@property (strong, nonatomic) IBOutlet UIButton *choiceBtn;

/*
 *无界商店数据模型
 */
@property (nonatomic, strong) id WuJieShopModel;
@end
