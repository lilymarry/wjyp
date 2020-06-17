//
//  SIndianaInforCell.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/4.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SIndianaInforCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *roundR;
@property (strong, nonatomic) IBOutlet UIImageView *headerImage;
@property (strong, nonatomic) IBOutlet UIView *groundView;

@property (strong, nonatomic) IBOutlet UILabel *thisNUm;
@property (strong, nonatomic) IBOutlet UILabel *time_num;
@property (strong, nonatomic) IBOutlet UILabel *bid_time;
@end
