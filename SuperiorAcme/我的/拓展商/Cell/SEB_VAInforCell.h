//
//  SEB_VAInforCell.h
//  SuperiorAcme
//
//  Created by GYM on 2018/1/17.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SEB_VAInforCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *thisImage;
@property (weak, nonatomic) IBOutlet UILabel *thisOne;
@property (weak, nonatomic) IBOutlet UILabel *thisTwo;

@property (weak, nonatomic) IBOutlet UIView *line_one;
@property (weak, nonatomic) IBOutlet UIView *line_two;
@end
