//
//  SOrderInforCell.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOrderInforCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UIButton *comeBtn;
@property (strong, nonatomic) IBOutlet UILabel *goods_name;
@property (strong, nonatomic) IBOutlet UILabel *shop_price;
@property (strong, nonatomic) IBOutlet UILabel *attr;
@property (strong, nonatomic) IBOutlet UILabel *goods_num;
@property (strong, nonatomic) IBOutlet UIImageView *goods_img;

@property (weak, nonatomic) IBOutlet UIButton *againBtn;
@property (weak, nonatomic) IBOutlet UILabel *timeCon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *comeBtn_WWW;

@property (weak, nonatomic) IBOutlet UIView *oneView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *oneView_HHH;
@property (weak, nonatomic) IBOutlet UIView *twoView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *twoView_HHH;
@property (weak, nonatomic) IBOutlet UIView *threeView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *threeView_HHH;

@property (weak, nonatomic) IBOutlet UILabel *invoice_name;
@property (weak, nonatomic) IBOutlet UILabel *after_sale_type;
@property (weak, nonatomic) IBOutlet UILabel *welfare;

@property (weak, nonatomic) IBOutlet UIView *integrity_aView;
@property (weak, nonatomic) IBOutlet UILabel *integrity_a;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *integrity_aViewHHH;

@property (weak, nonatomic) IBOutlet UIView *integrity_bView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *integrity_bView_HHH;
@property (weak, nonatomic) IBOutlet UILabel *integrity_b;

@property (weak, nonatomic) IBOutlet UIView *integrity_cView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *integrity_cView_HHH;
@property (weak, nonatomic) IBOutlet UILabel *integrity_c;
/*
 *体验拼单商品的提示标志
 */
@property (weak, nonatomic) IBOutlet UIImageView *onTrialImageView;
@property (weak, nonatomic) IBOutlet UIView *view_2980;
@property (weak, nonatomic) IBOutlet UILabel *lab_flag;


@end
