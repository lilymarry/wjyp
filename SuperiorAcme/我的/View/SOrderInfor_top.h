//
//  SOrderInfor_top.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOrderInfor_top : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UILabel *order_status;
@property (strong, nonatomic) IBOutlet UILabel *user_name;
@property (strong, nonatomic) IBOutlet UILabel *phone;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *merchant_name;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sendView_topHHH;
@property (strong, nonatomic) IBOutlet UIView *sendView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *sendView_HHH;
@property (strong, nonatomic) IBOutlet UILabel *logistics;
@property (strong, nonatomic) IBOutlet UILabel *logistics_time;

@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *addressView_HHH;
@property (weak, nonatomic) IBOutlet UIButton *freightBtn;
@property (weak, nonatomic) IBOutlet UIButton *merchant_inforBtn;
@end
