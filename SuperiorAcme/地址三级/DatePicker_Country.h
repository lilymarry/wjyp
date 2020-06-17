//
//  DatePicker_Country.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/18.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^DatePicker_Country_BackBlock) ();
typedef void(^DatePicker_Country_SubmitBlock) (NSString * one, NSString * two, NSString * three, NSString * one_id, NSString * two_id, NSString * three_id);

@interface DatePicker_Country : UIViewController

@property (nonatomic, copy) DatePicker_Country_BackBlock DatePicker_Country_Back;
@property (nonatomic, copy) DatePicker_Country_SubmitBlock DatePicker_Country_Submit;
@end
