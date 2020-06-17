//
//  SGoodsInfor_se3_footer.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/19.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SGoodsInfor_se3_footer : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UIButton *allEvaBtn;
@property (strong, nonatomic) IBOutlet UIImageView *headerImage;
@property (strong, nonatomic) IBOutlet UIButton *oneBtn;
@property (strong, nonatomic) IBOutlet UIButton *twoBtn;

@property (strong, nonatomic) IBOutlet UILabel *num1;
@property (strong, nonatomic) IBOutlet UILabel *num2;
@property (strong, nonatomic) IBOutlet UILabel *num3;

@property (strong, nonatomic) IBOutlet UILabel *total;
@property (strong, nonatomic) IBOutlet UILabel *nickname;
@property (strong, nonatomic) IBOutlet UILabel *content;

@property (strong, nonatomic) IBOutlet UIView *starView;
@property (strong, nonatomic) IBOutlet UIImageView *logo;
@property (strong, nonatomic) IBOutlet UILabel *merchant_name;
@property (strong, nonatomic) IBOutlet UILabel *all_goods;
@property (strong, nonatomic) IBOutlet UILabel *view_num;

@property (strong, nonatomic) IBOutlet UIView *merView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *merView_HHH;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *downView_HHH;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *evaNumView_topHHH;
@property (strong, nonatomic) IBOutlet UIView *evaNumView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *evaNumView_HHH;
@property (strong, nonatomic) IBOutlet UIView *evaContentView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *evaContentViewHHH;

@property (strong, nonatomic) IBOutlet UIView *eva_conentImageView;

@end
