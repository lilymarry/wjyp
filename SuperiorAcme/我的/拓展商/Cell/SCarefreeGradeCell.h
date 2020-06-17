//
//  SCarefreeGradeCell.h
//  SuperiorAcme
//
//  Created by GYM on 2018/1/17.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCarefreeGradeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *thisR;
@property (weak, nonatomic) IBOutlet UIImageView *backImage;

@property (weak, nonatomic) IBOutlet UILabel *rank_name;
@property (weak, nonatomic) IBOutlet UILabel *this_description;
@property (weak, nonatomic) IBOutlet UIImageView *is_discount;
@property (weak, nonatomic) IBOutlet UILabel *is_get;
@end
