//
//  SMessage_orderCell.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/14.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMessage_orderCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *ground;
@property (strong, nonatomic) IBOutlet UILabel *thisTitle;
@property (strong, nonatomic) IBOutlet UILabel *thisContent;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@end
