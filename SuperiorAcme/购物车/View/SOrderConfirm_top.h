//
//  SOrderConfirm_top.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOrderConfirm_top : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet UIButton *addressBtn;

@property (strong, nonatomic) IBOutlet UILabel *receiver;
@property (strong, nonatomic) IBOutlet UILabel *phone;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *merchant_name;
@end
