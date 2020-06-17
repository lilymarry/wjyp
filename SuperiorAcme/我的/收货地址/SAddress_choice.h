//
//  SAddress_choice.h
//  SuperiorAcme
//
//  Created by GYM on 2017/8/18.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SAddress_choice_choiceBlock) (NSString * thisName, NSString * this_id);

@interface SAddress_choice : UIViewController
@property (nonatomic, copy) NSString * area_id;//区县ID

@property (nonatomic, copy) SAddress_choice_choiceBlock SAddress_choice_choice;
@end
