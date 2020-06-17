//
//  SMemberOrderViewCell.h
//  SuperiorAcme
//
//  Created by GYM on 2018/3/13.
//  Copyright © 2018年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMemberOrderViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *one;
@property (weak, nonatomic) IBOutlet UILabel *two;
@property (weak, nonatomic) IBOutlet UILabel *three;
@property (weak, nonatomic) IBOutlet UILabel *four;
@property (weak, nonatomic) IBOutlet UILabel *status;

@property (weak, nonatomic) IBOutlet UIButton *oneBtn;
@property (weak, nonatomic) IBOutlet UIButton *twoBtn;
@end
