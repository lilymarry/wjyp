//
//  SEvaCar_header.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/30.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SEvaCar_header_StarNumBlock) (NSInteger index, NSInteger starNum);

@interface SEvaCar_header : UICollectionReusableView
@property (strong, nonatomic) IBOutlet UIView *oneStar;
@property (strong, nonatomic) IBOutlet UILabel *oneStar_title;
@property (strong, nonatomic) IBOutlet UIView *twoStar;
@property (strong, nonatomic) IBOutlet UILabel *twoStar_title;
@property (strong, nonatomic) IBOutlet UIView *threeStar;
@property (strong, nonatomic) IBOutlet UILabel *threeStar_title;
@property (strong, nonatomic) IBOutlet UIView *fourStar;
@property (strong, nonatomic) IBOutlet UILabel *fourStar_title;
@property (strong, nonatomic) IBOutlet UIView *fiveStar;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *fiveStar_HHH;

@property (strong, nonatomic) IBOutlet UIImageView *car_img;
@property (strong, nonatomic) IBOutlet UILabel *car_name;
@property (strong, nonatomic) IBOutlet UILabel *pre_moneyR;
@property (strong, nonatomic) IBOutlet UILabel *pre_money;
@property (strong, nonatomic) IBOutlet UILabel *all_price;
@property (strong, nonatomic) IBOutlet UILabel *true_pre_money;

@property (nonatomic, copy) SEvaCar_header_StarNumBlock SEvaCar_header_StarNum;
@end
