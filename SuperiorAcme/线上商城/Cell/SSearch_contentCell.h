//
//  SSearch_contentCell.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/14.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSearch_contentCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *classView;
@property (strong, nonatomic) IBOutlet UIButton *choiceBtn;
@property (strong, nonatomic) IBOutlet UIButton *goShopBtn;

@property (strong, nonatomic) IBOutlet UIImageView *logo;
@property (strong, nonatomic) IBOutlet UILabel *merchant_name;
@property (strong, nonatomic) IBOutlet UILabel *merchant_desc;
@property (strong, nonatomic) IBOutlet UILabel *score;

@end
