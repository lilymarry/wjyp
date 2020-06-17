//
//  SAddress.h
//  SuperiorAcme
//
//  Created by GYM on 2017/7/26.
//  Copyright © 2017年 GYM. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SAddress_ChoiceBlock) (NSString * province, NSString * city, NSString * area, NSString * address,NSString * address_id, NSString * receiver, NSString * phone);

@interface SAddress : UIViewController

@property (nonatomic, assign) BOOL choice_isno;//YES返回
@property (nonatomic, copy) SAddress_ChoiceBlock SAddress_Choice;
@end
