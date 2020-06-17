//
//  SLineShop_infor_Right.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SLineShop_infor_Right_ScrollDelegateBlock) (CGFloat y);
typedef void(^SLineShop_infor_Right_goCarBlock) ();
typedef void(^SLineShop_infor_Right_SubmitBlock) ();
typedef void(^SLineShop_infor_Right_couponBlock) ();

@interface SLineShop_infor_Right : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;

@property (strong, nonatomic) IBOutlet UIView *downView;
@property (strong, nonatomic) IBOutlet UILabel *car_num;
@property (strong, nonatomic) IBOutlet UITableView *mTable_left;
@property (strong, nonatomic) IBOutlet UITableView *mTable_right;

@property (nonatomic, copy) SLineShop_infor_Right_ScrollDelegateBlock SLineShop_infor_Right_ScrollDelegate;
@property (nonatomic, copy) SLineShop_infor_Right_goCarBlock SLineShop_infor_Right_goCar;
@property (nonatomic, copy) SLineShop_infor_Right_SubmitBlock SLineShop_infor_Right_Submit;
@property (nonatomic, copy) SLineShop_infor_Right_couponBlock SLineShop_infor_Right_coupon;
@end
