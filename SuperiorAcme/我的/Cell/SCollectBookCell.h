//
//  SCollectBookCell.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/26.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCollectBookCell : UITableViewCell
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *headerImage_WWW;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *line_WWW;

@property (strong, nonatomic) IBOutlet UIButton *choiceBtn;

@property (strong, nonatomic) IBOutlet UIImageView *logo;
@property (strong, nonatomic) IBOutlet UILabel *thisTitle;
@property (strong, nonatomic) IBOutlet UILabel *page_views_collect_num;
@end
