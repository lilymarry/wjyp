//
//  SOrderCenter_listViewCell.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOrderCenter_listViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *thisType;
@property (strong, nonatomic) IBOutlet UILabel *thisNum;

@property (strong, nonatomic) IBOutlet UIImageView *car_img;
@property (strong, nonatomic) IBOutlet UILabel *car_name;
@property (strong, nonatomic) IBOutlet UILabel *pre_money;
/*
 *添加体验拼单商品提示
 */

@property (weak, nonatomic) IBOutlet UIImageView *onTrialImageView;
//2980 标签
@property (weak, nonatomic) IBOutlet UIView *view_2980;
@property (weak, nonatomic) IBOutlet UILabel *lab_flag;
@end
