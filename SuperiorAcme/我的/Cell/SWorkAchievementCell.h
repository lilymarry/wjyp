//
//  SWorkAchievementCell.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/26.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWorkAchievementCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headerImage;
@property (strong, nonatomic) IBOutlet UILabel *num;

@property (strong, nonatomic) IBOutlet UIImageView *thisR;
@property (strong, nonatomic) IBOutlet UIImageView *thisR_othre;
@property (strong, nonatomic) IBOutlet UILabel *othre_num;
@property (strong, nonatomic) IBOutlet UILabel *nickname;
@end
