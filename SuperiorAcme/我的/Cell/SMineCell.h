//
//  SMineCell.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/20.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMineCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headerImage;
@property (strong, nonatomic) IBOutlet UILabel *thisTitle;
@property (weak, nonatomic) IBOutlet UIImageView *rightR;

@end
