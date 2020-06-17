//
//  SEvaAllCell.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/2.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SEvaAllCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *thisContent;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *thisContent_HHH;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *thisContent_TopHHH;
@property (strong, nonatomic) IBOutlet UIImageView *head_pic;
@property (strong, nonatomic) IBOutlet UILabel *nickname;
@property (strong, nonatomic) IBOutlet UILabel *content;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *content_HHH;
@property (strong, nonatomic) IBOutlet UILabel *create_time;
@property (strong, nonatomic) IBOutlet UIView *starView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *timeTop_HHH;


- (void)showModel:(NSArray *)arr andType:(NSString *)type;
@end
