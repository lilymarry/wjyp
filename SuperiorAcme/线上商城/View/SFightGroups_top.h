//
//  SFightGroups_top.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/2.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SGroupBuyOrderOffered.h"

@interface SFightGroups_top : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;

@property (weak, nonatomic) IBOutlet UILabel *goods_name;
@property (weak, nonatomic) IBOutlet UIImageView *goods_img;
@property (strong, nonatomic) IBOutlet UILabel *thisNum;
@property (weak, nonatomic) IBOutlet UILabel *shop_price;
@property (strong, nonatomic) IBOutlet UIImageView *leftImage;
@property (strong, nonatomic) IBOutlet UIImageView *rightImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *thisImageView_WWW;
@property (weak, nonatomic) IBOutlet UILabel *status_title;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
/*
 *拼单须知标题
 */
@property (weak, nonatomic) IBOutlet UILabel *groupIntroduceTitleLabel;

/*
 *增加参团数据模型属性,用于设置倒计时时间的显示
 */
@property (nonatomic, strong) SGroupBuyOrderOffered * offeredModel;
@end
