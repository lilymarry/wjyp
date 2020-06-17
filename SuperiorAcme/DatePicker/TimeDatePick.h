//
//  TimeDatePick.h
//  HouseFB
//
//  Created by TXD_air on 16/8/17.
//  Copyright © 2016年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^TimeDatePickSubmit_YMDBlock) (NSString * myYear, NSString * myMonth, NSString * myDay, NSString * myHour, NSString * myMinute);
typedef void(^TimeDatePickBackBlock) ();
typedef void(^TimeDatePick_foreverBtnBlock) ();

@interface TimeDatePick : UIViewController
@property (nonatomic, copy) NSString * type;//1:年月日 2:时分
@property (nonatomic, copy) TimeDatePickSubmit_YMDBlock TimeDatePickSubmit_YMD;
@property (nonatomic, copy) TimeDatePickBackBlock TimeDatePickBack;
@property (nonatomic, copy) TimeDatePick_foreverBtnBlock TimeDatePick_foreverBtn;

@property (nonatomic, copy) NSArray * thisHour;//时
@property (strong, nonatomic) IBOutlet UIButton *foreverBtn;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *foreverBtn_HHH;
@property (nonatomic, strong) UIDatePicker * datePicker;
@property (strong, nonatomic) IBOutlet UIButton *subMitBtn;

- (void)hiddenForever;
@end
