//
//  SOnlineShop_top.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/13.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOnlineShop_top : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (weak, nonatomic) IBOutlet UIImageView *bannerTopImage;
@property (strong, nonatomic) IBOutlet UIView *bannerView;
@property (strong, nonatomic) IBOutlet UIView *classView;
@property (strong, nonatomic) IBOutlet UIView *headerlineView;
@property (strong, nonatomic) IBOutlet UIButton *oneBtn;//限量购
@property (strong, nonatomic) IBOutlet UIButton *twoBtn;//票券区
@property (strong, nonatomic) IBOutlet UIButton *threeBtn;//拼团区
@property (strong, nonatomic) IBOutlet UIButton *fourBtn;//主题街
@property (strong, nonatomic) IBOutlet UIButton *fiveBtn;//无界预购
@property (strong, nonatomic) IBOutlet UIButton *sexBtn;//进口馆
@property (strong, nonatomic) IBOutlet UIButton *sevenBtn;//竞拍汇
@property (strong, nonatomic) IBOutlet UIButton *eightBtn;//汽车购
@property (strong, nonatomic) IBOutlet UIButton *nineBtn;//房产购
@property (strong, nonatomic) IBOutlet UIButton *tenBtn;//积分夺宝
@property (strong, nonatomic) IBOutlet UIButton *headlinesBtn;//无界头条

@property (strong, nonatomic) IBOutlet UIButton *brandBtn;
@property (strong, nonatomic) IBOutlet UIButton *chinaBtn;
@property (strong, nonatomic) IBOutlet UIButton *scienceBtn;

@property (strong, nonatomic) IBOutlet UIImageView *header_mImage1;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *header1_mImage1HHH;

@property (strong, nonatomic) IBOutlet UIImageView *header_mImage2;
@property (weak, nonatomic) IBOutlet UIButton *imageBtn0;
@property (weak, nonatomic) IBOutlet UIView *actionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *actionView_HHH;

@property (weak, nonatomic) IBOutlet UILabel *fiveLab;


@property (weak, nonatomic) IBOutlet UIView *btnView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnViewHHH;




@end
