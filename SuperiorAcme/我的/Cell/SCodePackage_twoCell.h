//
//  SCodePackage_twoCell.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/26.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCodePackage_twoCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *groundView;
@property (strong, nonatomic) IBOutlet UILabel *thisTitle;
@property (strong, nonatomic) IBOutlet UILabel *thisContent;
@property (strong, nonatomic) IBOutlet UILabel *oneT;
@property (strong, nonatomic) IBOutlet UILabel *twoT;
@property (strong, nonatomic) IBOutlet UILabel *threeT;
@property (strong, nonatomic) IBOutlet UIImageView *rigthImageR;
@property (strong, nonatomic) IBOutlet UIImageView *rightImageR_sub;

//特殊显示
@property (strong, nonatomic) IBOutlet UIView *showTimeView;
@property (strong, nonatomic) IBOutlet UIButton *showTimeBtn;
@property (strong, nonatomic) IBOutlet UIView *showTime_conetne;
@property (strong, nonatomic) IBOutlet UILabel *showTime_num;
@property (strong, nonatomic) IBOutlet UIImageView *headerImage;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *oneT_HHH;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *threeT_HHH;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *twoT_WWW;

@end
