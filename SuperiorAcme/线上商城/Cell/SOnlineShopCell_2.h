//
//  SOnlineShopCell_2.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/12.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOnlineShopCell_2 : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UILabel *top_title;
@property (strong, nonatomic) IBOutlet UILabel *songR;
@property (strong, nonatomic) IBOutlet UILabel *submit;
@property (strong, nonatomic) IBOutlet UIImageView *header1;
@property (strong, nonatomic) IBOutlet UIImageView *header2;

@property (strong, nonatomic) IBOutlet UIImageView *country_logo;
@property (strong, nonatomic) IBOutlet UIImageView *goods_img;
@property (strong, nonatomic) IBOutlet UILabel *goods_name;
@property (strong, nonatomic) IBOutlet UILabel *group_price;
@property (strong, nonatomic) IBOutlet UILabel *total;
@property (strong, nonatomic) IBOutlet UILabel *integral;
@property (strong, nonatomic) IBOutlet UILabel *simple_proce;
@property (strong, nonatomic) IBOutlet UILabel *simple_num;

/*
 *添加simple_proce的高度约束,设置单买价的不显示
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *simple_proceHeightCons;

/*
 *添加体验拼单商品提示
 */
@property (weak, nonatomic) IBOutlet UIImageView *onTrialTipImageView;

@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@end
