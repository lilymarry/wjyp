//
//  attr_tableCell.h
//  SuperiorAcme
//
//  Created by GYM on 2018/2/6.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface attr_tableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *attr_name;
@property (weak, nonatomic) IBOutlet UILabel *attr_value;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mview_HHH;
@end
