//
//  SMemberCell.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/21.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMemberCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *level_name;
@property (strong, nonatomic) IBOutlet UILabel *points;
@property (strong, nonatomic) IBOutlet UILabel *is_get;
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@end
