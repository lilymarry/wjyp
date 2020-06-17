//
//  SWelfareAgency_play.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SWelfareAgency_play_backBlock) ();
typedef void(^SWelfareAgency_play_shareBlock) ();

@interface SWelfareAgency_play : UIView

@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UIImageView *thisImage;
@property (strong, nonatomic) IBOutlet UIImageView *thisImageGround;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (strong, nonatomic) IBOutlet UIImageView *comImage;
@property (strong, nonatomic) IBOutlet UILabel *comName;
@property (strong, nonatomic) IBOutlet UIImageView *shareImage;
@property (strong, nonatomic) IBOutlet UIButton *shareBtn;
@property (strong, nonatomic) IBOutlet UILabel *leftTitle;
@property (strong, nonatomic) IBOutlet UIButton *rightBtn;
@property (strong, nonatomic) IBOutlet UIView *groundView;
@property (strong, nonatomic) IBOutlet UIView *playerView;
@property (strong, nonatomic) IBOutlet UIButton *playBtn;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *playActiv;

- (void)showModel:(NSArray *)ads_list andLogo:(NSString *)logo andName:(NSString * )merchant_name;

@property (nonatomic, copy) SWelfareAgency_play_backBlock SWelfareAgency_play_back;
@property (nonatomic, copy) SWelfareAgency_play_shareBlock SWelfareAgency_play_share;
@end
