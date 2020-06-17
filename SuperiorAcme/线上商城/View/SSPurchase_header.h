//
//  SSPurchase_header.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/24.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSPurchase_header : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UIView *lineView;
@property (strong, nonatomic) IBOutlet UIButton *openBtn;
@property (strong, nonatomic) IBOutlet UIView *showCollect;

@property (strong, nonatomic) IBOutlet UILabel *group_name;
@property (strong, nonatomic) IBOutlet UILabel *ticket_buy_discount;
@property (strong, nonatomic) IBOutlet UILabel *group_price;
@property (strong, nonatomic) IBOutlet UILabel *integral;
@property (strong, nonatomic) IBOutlet UILabel *songR;
@property (strong, nonatomic) IBOutlet UILabel *delPrice;

- (void)showModel:(NSArray *)arr;
@end
