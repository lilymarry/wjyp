//
//  SHouseInforCell.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/18.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHouseInforCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headerImage;
@property (strong, nonatomic) IBOutlet UIView *starView;
@property (strong, nonatomic) IBOutlet UILabel *nickname;
@property (strong, nonatomic) IBOutlet UILabel *create_time;
@property (strong, nonatomic) IBOutlet UILabel *content;
@property (strong, nonatomic) IBOutlet UIView *thisContent;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *content_HHH;

- (void)showModel:(NSArray *)arr;
@end
