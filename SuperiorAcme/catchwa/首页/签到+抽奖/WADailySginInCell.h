//
//  WADailySginInCell.h
//  CatchWAWA
//
//  Created by 天津沃天科技 on 2019/1/19.
//  Copyright © 2019年 wotianshiyan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WADailySginInCell : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UIButton *backBtn;
@property (strong, nonatomic) IBOutlet UIImageView *picImaView;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *nameBottomHH;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *nameHHH;
@property (strong, nonatomic) IBOutlet UIView *view1;
@property (strong, nonatomic) IBOutlet UIImageView *v1_imagView;


@property (strong, nonatomic) IBOutlet UIView *view2;
@property (strong, nonatomic) IBOutlet UILabel *v2_lab;

@property (strong, nonatomic) IBOutlet UIView *view3;
@property (strong, nonatomic) IBOutlet UILabel *v3_lab;
@property (strong, nonatomic) IBOutlet UIImageView *v3_imagView;





@end

NS_ASSUME_NONNULL_END
