//
//  SOrderCenter_listView_header.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/31.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOrderCenter_listView_header : UIView
@property (strong, nonatomic) IBOutlet UIView *thisView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *leftR_www;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *leftR_WWW;
@property (strong, nonatomic) IBOutlet UIImageView *leftR;
@property (strong, nonatomic) IBOutlet UIImageView *directR;
@property (strong, nonatomic) IBOutlet UILabel *thisTitle;
@property (strong, nonatomic) IBOutlet UILabel *thisType;

@property (strong, nonatomic) IBOutlet UIButton *mapBtn;
@end
