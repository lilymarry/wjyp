//
//  SAddressCell.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/26.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAddressCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *line;
@property (strong, nonatomic) IBOutlet UIButton *choiceBtn;
@property (strong, nonatomic) IBOutlet UIButton *oneBtn;
@property (strong, nonatomic) IBOutlet UIButton *twoBtn;

@property (strong, nonatomic) IBOutlet UILabel *receiver;
@property (strong, nonatomic) IBOutlet UILabel *phone;
@property (strong, nonatomic) IBOutlet UILabel *address;


@end
