//
//  SLotInfor_top.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/3.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SLotInfor_top : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UIView *bannerView;
@property (strong, nonatomic) IBOutlet UILabel *stage_status;
@property (strong, nonatomic) IBOutlet UILabel *is_end_desc;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *is_end_desc_HHH;
@property (strong, nonatomic) IBOutlet UILabel *is_new_goods_desc;
@property (strong, nonatomic) IBOutlet UIView *is_EndNewView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *is_EndNewView_HHH;
@property (strong, nonatomic) IBOutlet UILabel *auth_desc;
@property (strong, nonatomic) IBOutlet UIView *auth_descGround;

@property (strong, nonatomic) IBOutlet UILabel *songR;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *auth_desc_HHH;

@property (strong, nonatomic) IBOutlet UILabel *auct_name;
@property (strong, nonatomic) IBOutlet UILabel *now_price;
@property (strong, nonatomic) IBOutlet UILabel *integral;
@property (strong, nonatomic) IBOutlet UILabel *click_num;
@property (strong, nonatomic) IBOutlet UILabel *apply_num;
@property (strong, nonatomic) IBOutlet UILabel *remind_num;

@property (strong, nonatomic) IBOutlet UILabel *start_price;
@property (strong, nonatomic) IBOutlet UILabel *add_price;
@property (strong, nonatomic) IBOutlet UILabel *start_time;
@property (strong, nonatomic) IBOutlet UILabel *leave_price;
@property (strong, nonatomic) IBOutlet UILabel *base_money;
@property (strong, nonatomic) IBOutlet UILabel *thisEnd_time;
@property (strong, nonatomic) IBOutlet UILabel *delay_time;

@property (strong, nonatomic) IBOutlet UILabel *mybid;
@property (strong, nonatomic) IBOutlet UIView *mybid_oneView;
@property (strong, nonatomic) IBOutlet UIView *mybid_twoView;
@end
