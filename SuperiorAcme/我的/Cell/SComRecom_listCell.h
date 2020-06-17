//
//  SComRecom_listCell.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/21.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SComRecom_listCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *product_pic;
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *create_time;
@property (strong, nonatomic) IBOutlet UILabel *thisStatus;

@end
