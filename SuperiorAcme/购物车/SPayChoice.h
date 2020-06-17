//
//  SPayChoice.h
//  SuperiorAcme
//
//  Created by GYM on 2017/11/29.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SPayChoice_choiceBlock) (NSInteger num);

@interface SPayChoice : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *redBtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *redBtn_HHH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redDes_HHH;
@property (strong, nonatomic) IBOutlet UIButton *yellowBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *yellowDes_HHH;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *yellowBtn_HHH;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bluBtn_HHH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bluDes_HHH;

@property (strong, nonatomic) IBOutlet UIButton *blueBtn;
@property (strong, nonatomic) IBOutlet UILabel *red_des;
@property (strong, nonatomic) IBOutlet UILabel *yellow_des;
@property (strong, nonatomic) IBOutlet UILabel *blue_des;


@property (strong, nonatomic) IBOutlet UIButton *notBtn;
@property (nonatomic, copy) SPayChoice_choiceBlock SPayChoice_choice;
@end
