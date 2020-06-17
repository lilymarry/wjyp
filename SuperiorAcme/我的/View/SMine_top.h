//
//  SMine_top.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/20.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SUserUserCenter.h"

typedef void(^TopBtnBlock)(NSInteger type);

@interface SMine_top : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UIImageView *headerImage;
@property (strong, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nickname_HHH;
@property (strong, nonatomic) IBOutlet UIView *oneView;
@property (strong, nonatomic) IBOutlet UIView *twoView;
@property (strong, nonatomic) IBOutlet UIButton *oneBtn;//会员成长
@property (strong, nonatomic) IBOutlet UIImageView *oneImage;
@property (strong, nonatomic) IBOutlet UILabel *oneNick;
@property (strong, nonatomic) IBOutlet UIButton *twoBtn;//会员等级
@property (strong, nonatomic) IBOutlet UIImageView *twoImage;
@property (strong, nonatomic) IBOutlet UILabel *twoNick;
@property (strong, nonatomic) IBOutlet UILabel *lastTime;
@property (strong, nonatomic) IBOutlet UIButton *lastBtn;
@property (strong, nonatomic) IBOutlet UIButton *threeBtn;//余额
@property (strong, nonatomic) IBOutlet UILabel *threeNum;
@property (strong, nonatomic) IBOutlet UIButton *fourBtn;//积分
@property (strong, nonatomic) IBOutlet UILabel *fourNum;
@property (strong, nonatomic) IBOutlet UIButton *fiveBtn;//购物券
@property (strong, nonatomic) IBOutlet UILabel *fiveNum;

@property (strong, nonatomic) IBOutlet UIImageView *mOneImage;
@property (strong, nonatomic) IBOutlet UIImageView *mTwoImage;
@property (strong, nonatomic) IBOutlet UIImageView *mThreeImage;
@property (strong, nonatomic) IBOutlet UIImageView *mFourImage;
@property (strong, nonatomic) IBOutlet UIImageView *mFiveImage;

@property (nonatomic, copy) TopBtnBlock topBtnBlock;

//显示延长会员
@property (weak, nonatomic) IBOutlet UIButton *yanChangHuiYuanBtn;


- (void)setValue:(SUserUserCenter *)center;
- (void)viewIsShow:(BOOL)isNo;

@end
