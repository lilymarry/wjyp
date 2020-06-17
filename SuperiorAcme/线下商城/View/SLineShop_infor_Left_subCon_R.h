//
//  SLineShop_infor_Left_subCon_R.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SLineShop_infor_Left_subCon_R_showBlock) ();

@interface SLineShop_infor_Left_subCon_R : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;

@property (strong, nonatomic) IBOutlet UIView *topDiscountView;
@property (strong, nonatomic) IBOutlet UILabel *topDiscount_R;
@property (strong, nonatomic) IBOutlet UIButton *couponBtn;

@property (nonatomic, copy) SLineShop_infor_Left_subCon_R_showBlock SLineShop_infor_Left_subCon_R_show;


@property (strong, nonatomic) IBOutlet UILabel *ticket_num;
@end
