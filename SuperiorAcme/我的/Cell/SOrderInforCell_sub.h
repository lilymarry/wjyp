//
//  SOrderInforCell_sub.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/1.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOrderInforCell_sub : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *pre_status;
@property (weak, nonatomic) IBOutlet UILabel *start;
@property (weak, nonatomic) IBOutlet UILabel *start_top_title;
@property (weak, nonatomic) IBOutlet UILabel *start_title;
@property (weak, nonatomic) IBOutlet UILabel *start_integral;
@property (weak, nonatomic) IBOutlet UILabel *endTitle;
@property (weak, nonatomic) IBOutlet UILabel *end;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topView_HHH;
@property (weak, nonatomic) IBOutlet UILabel *top_senTitle;
@property (weak, nonatomic) IBOutlet UILabel *top_senPrice;
@property (weak, nonatomic) IBOutlet UILabel *downTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *downTitle_HHH;
@end
